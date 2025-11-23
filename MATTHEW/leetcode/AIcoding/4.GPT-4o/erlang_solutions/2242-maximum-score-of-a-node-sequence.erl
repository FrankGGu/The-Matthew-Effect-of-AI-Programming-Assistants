-module(solution).
-export([maximum_score/3]).

maximum_score(A, B, C) ->
    lists:foldl(fun({X, Y, Z}, Acc) ->
        Max = lists:max([X, Y, Z]),
        MaxScore = (X + Y + Z) - (3 * Max),
        lists:max([Acc, MaxScore])
    end, 0, [{A, B, C}]).