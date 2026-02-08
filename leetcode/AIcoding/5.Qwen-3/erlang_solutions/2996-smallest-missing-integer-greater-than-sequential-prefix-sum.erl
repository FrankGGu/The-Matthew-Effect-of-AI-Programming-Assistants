-module(solution).
-export([missing_integer/1]).

missing_integer(Numbers) ->
    PrefixSums = lists:scanl(fun(X, Acc) -> X + Acc end, 0, Numbers),
    SortedPrefixes = lists:usort(PrefixSums),
    find_missing(SortedPrefixes, 1).

find_missing([], _) -> 1;
find_missing([H | T], N) ->
    if
        H == N -> find_missing(T, N + 1);
        true -> N
    end.