-module(solution).
-export([find_closest/4]).

find_closest(List, K, X) ->
    Sorted = lists:sort(fun(A, B) -> abs(A - X) < abs(B - X) end, List),
    Closest = lists:sublist(Sorted, K),
    lists:sort(Closest).