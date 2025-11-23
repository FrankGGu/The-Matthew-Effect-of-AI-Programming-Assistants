-module(solution).
-export([largestOddNumber/1]).

largestOddNumber(Num) ->
    Len = length(Num),
    find_rightmost_odd(Num, Len - 1).

find_rightmost_odd(Num, Index) when Index >= 0 ->
    DigitChar = lists:nth(Index + 1, Num),
    Digit = DigitChar - $0,
    if
        Digit rem 2 =/= 0 ->
            lists:sublist(Num, 1, Index + 1);
        true ->
            find_rightmost_odd(Num, Index - 1)
    end;
find_rightmost_odd(_Num, _Index) ->
    "".