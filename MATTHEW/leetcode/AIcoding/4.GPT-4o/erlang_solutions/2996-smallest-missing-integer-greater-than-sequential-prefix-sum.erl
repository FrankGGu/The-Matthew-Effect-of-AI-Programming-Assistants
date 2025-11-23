-module(solution).
-export([smallest_missing_integer/1]).

smallest_missing_integer(List) ->
    Sorted = lists:sort(List),
    PrefixSum = lists:scanl(fun(X, Acc) -> X + Acc end, 0, Sorted),
    Missing = find_missing(PrefixSum, 1),
    Missing.

find_missing([], _) -> 1;
find_missing([H | T], Acc) when H == Acc -> find_missing(T, Acc + 1);
find_missing([H | _], Acc) when H > Acc -> Acc.