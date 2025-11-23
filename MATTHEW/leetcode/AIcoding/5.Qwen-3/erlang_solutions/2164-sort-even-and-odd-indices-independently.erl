-module(solution).
-export([sort_even_odd/1]).

sort_even_odd(List) ->
    Even = [X || {I, X} <- lists:enumerate(List), I rem 2 == 0],
    Odd = [X || {I, X} <- lists:enumerate(List), I rem 2 == 1],
    EvenSorted = lists:sort(Even),
    OddSorted = lists:sort(Odd),
    merge(EvenSorted, OddSorted, 1, []).

merge([], [], _, Acc) -> lists:reverse(Acc);
merge([H|T], Odd, 1, Acc) -> merge(T, Odd, 2, [H | Acc]);
merge(Even, [H|T], 2, Acc) -> merge(Even, T, 1, [H | Acc]).