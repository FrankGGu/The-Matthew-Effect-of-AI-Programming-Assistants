-module(solution).
-export([highest_altitude/1]).

highest_altitude(Gains) ->
    lists:foldl(fun(X, Acc) -> max(Acc + X, Acc + X) end, 0, Gains).