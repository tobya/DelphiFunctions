{*******************************************************************
*  TFMLetterAlphaRep written by Toby Allen 1998.  Conversion of Numeric
* value to base 24  letter AlphaRep.  Ie. 1 returns A, 2 returns B ... 27 
* returns AA etc.  Limited to 7 Alpha characters - as this is the number of characters
* in the representation of the max longint value.  
* The source could easily be updated to do larger numbers if need be.
* Send me a copy. This is Freeware, noteware, feedbackware whatever you want.  
* Toby_allen@hotmail.com

* Updated 15/08/2001
* Tidied UP.
*******************************************************************}

{Use:
Fairly simple.  Just call GetAlphaRep with two arguments.  First argument is the 
number you wish to have converted, the second is a boolean indicating whether or not
to use the fullalphabet or a subset that doesnt use I & O due to being easily 
mistaken for 1 or 0.  One word of warning use one or other value for an entire 
application do not mix unless you know what your doing.

}

unit TFMAlphaRep;

interface

uses SysUtils;


    {Functions to Get Letter AlphaRep from Number}
    Function GetAlphaRep(NumericRep : Longint; FULLAlphabet : Boolean) : String;
    Function GetLetter(Number : Longint; Full: Boolean) : String;

Const
    cLetterStringFull   = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
    cLetterStringSub    = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

implementation

Function GetAlphaRep(NumericRep : Longint; FULLAlphabet : Boolean) : String;
Var
    item, Count : byte;
    Letterlist : Array[0..6] of Integer;  {... 7 letter Rep needed for max longint value}
    Number : Longint;  {Storing Number}
    Done : Boolean;  {Get out of loop boolean}
    Divides, Remainder : Longint; {...Variables to contain Computation parameters.}
    AlphaRep : String; {... Final Alpha Representation for insertion in Document. }
    SizeAlpha : Byte; {...Size of Alphabet 24 or 26 depending on FullAlphabet value}
Begin

    If FullAlphabet then
        SizeAlpha := 26
    else
        SizeAlpha := 24;

    {... Initialise Array. }
    For item := 0 to 6 do
    begin
        Letterlist[item] := -1;
    end;
    {... Initialise other variables. }
    Done := false;
    Number := NumericRep;
    Count := 0;

    Repeat
        if Number > SizeAlpha -1 then  {... 0- 23 because i,0 arent used, due to similarity to 1 and 0}
        begin
           Divides := Number div SizeAlpha;  {... Divides hold the number of times 24 div in.}

            {... Remainder holds the remainder on division by 24 the remainder will be < 24 for obvious reasons.}
           Remainder := Number mod SizeAlpha;
           LetterList[Count] := Remainder; {assign remainder to next slot in our 							AlphaRep list }
           Number := Divides; {Reset the number to divide}
           inc(Count);
        end
        else
           Done := True

    Until Done = True;
    LetterList[Count] := Number;  {... Record final division.}

    {... All the slots in the array from 0 -6 are gone through and the number in it < 24 is turned into a letter by calling getletter this is added to the AlphaRep string.}
    For Item := 0 to 6 do
    begin
        if letterlist[item] > -1 then
            AlphaRep := GetLetter(letterlist[item], FullAlphabet) + AlphaRep;
    end;
    Result :=  AlphaRep;
end;

{... One big case statement that returns a letter from A -Z skipping I & 0.}
Function GetLetter(Number : Integer; Full : Boolean) : String;
Begin
    If Full then
    Begin
        Result := cLetterStringFull[Number];
    End
    Else
    begin
        Result := cLetterStringSub[Number];
    end;
end;
end.
