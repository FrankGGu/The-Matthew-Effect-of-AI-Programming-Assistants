-module(shifting_letters_ii).
-export([shifting_letters/2]).

shifting_letters(Chars, Shifts) ->
    Len = length(Chars),
    Acc = lists:seq(0, Len - 1),
    {_, Result} = lists:foldl(fun({Shift, Index}, {TotalShift, AccList}) ->
        NewTotalShift = (TotalShift + Shift) rem 26,
        NewAccList = lists:sublist(AccList, Index) ++ [lists:nth(Index + 1, AccList) + NewTotalShift] ++ lists:sublist(AccList, Index + 2, Len - Index - 1),
        {NewTotalShift, NewAccList}
    end, {0, Acc}, lists:zip(Shifts, Acc)),
    lists:map(fun(I) -> lists:nth(I + 1, Chars) end, Result).