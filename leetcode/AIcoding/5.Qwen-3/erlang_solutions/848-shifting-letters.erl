-module(shifting_letters).
-export([shifting_letters/2]).

shifting_letters(Chars, Shifts) ->
    Len = length(Chars),
    TotalShifts = lists:foldl(fun({Shift, Index}, Acc) -> 
        Acc + Shift * (Len - Index)
    end, 0, lists:zip(Shifts, lists:seq(0, Len-1))),
    TotalShiftsMod = TotalShifts rem 26,
    lists:map(fun({Char, Index}) ->
        Offset = Char - $a,
        NewOffset = (Offset + TotalShiftsMod) rem 26,
        NewChar = NewOffset + $a,
        NewChar
    end, lists:zip(Chars, lists:seq(0, Len-1))).

shifting_letters(Chars, Shifts) ->
    shifting_letters(Chars, Shifts).