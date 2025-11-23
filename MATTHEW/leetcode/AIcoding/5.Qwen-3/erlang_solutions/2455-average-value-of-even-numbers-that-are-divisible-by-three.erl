-module(even_divisible_by_three).
-export([average/1]).

average(Numbers) ->
    EvenDiv3 = [N || N <- Numbers, N rem 2 == 0, N rem 3 == 0],
    Count = length(EvenDiv3),
    if
        Count == 0 -> 0;
        true -> lists:sum(EvenDiv3) div Count
    end.