-module(solution).
-export([minimum_difference/2]).

minimum_difference(Str1, Str2) ->
    Sorted1 = lists:sort(string:to_list(Str1)),
    Sorted2 = lists:sort(string:to_list(Str2)),
    lists:foldl(fun(X, Acc) -> Acc + abs(lists:nth(X + 1, Sorted1) - lists:nth(X + 1, Sorted2)) end, 0, lists:seq(0, length(Sorted1) - 1)).