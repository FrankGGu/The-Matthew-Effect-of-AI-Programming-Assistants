-module(solution).
-export([find_combinations/1]).

find_combinations(Target) ->
    find_combinations(Target, 0, []).

find_combinations(0, Combination) ->
    [Combination];
find_combinations(Target, Current) when Target > 0 ->
    lists:flatmap(fun(X) -> find_combinations(Target - X, Current ++ [X]) end, [1, 2, 3]).