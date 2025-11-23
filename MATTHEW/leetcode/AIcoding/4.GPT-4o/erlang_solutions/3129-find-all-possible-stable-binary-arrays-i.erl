-module(solution).
-export([find_stable_arrays/1]).

find_stable_arrays(N) ->
    find_stable_arrays(N, [], 0).

find_stable_arrays(0, Acc, _) ->
    [lists:reverse(Acc)];
find_stable_arrays(N, Acc, Prev) ->
    lists:flatmap(fun(X) -> find_stable_arrays(N - 1, [X | Acc], X) end, get_next_values(Prev)).

get_next_values(0) -> [0, 1];
get_next_values(1) -> [0, 1];
get_next_values(2) -> [0, 1];
get_next_values(3) -> [0, 1];
get_next_values(Prev) ->
    [0, 1] ++ [2, 3] -- [Prev].