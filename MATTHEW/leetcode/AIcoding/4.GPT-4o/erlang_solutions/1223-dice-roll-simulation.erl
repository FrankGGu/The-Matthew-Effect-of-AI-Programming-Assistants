-module(solution).
-export([die_simulation/1]).

die_simulation(N) ->
    die_count(N, 1).

die_count(0, _) -> 
    1;
die_count(N, LastRoll) ->
    Sum = lists:sum(lists:map(fun(X) -> die_count(N - 1, X) end, [1,2,3,4,5,6] -- [LastRoll])),
    Sum.