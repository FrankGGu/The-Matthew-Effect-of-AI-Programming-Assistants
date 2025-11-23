-module(solution).
-export([solve/1]).

solve(S) ->
    N = length(S),
    Sum = lists:foldl(fun(Char, Acc) -> Acc + (Char - $a + 1) end, 0, S),
    convert(Sum).

convert(Num) when Num < 10 ->
    Num;
convert(Num) ->
    convert(lists:sum([Digit || Digit <- integer_to_list(Num)])).

solve(S) ->
    N = length(S),
    Sum = lists:foldl(fun(Char, Acc) -> Acc + (Char - $a + 1) end, 0, S),
    convert(Sum).