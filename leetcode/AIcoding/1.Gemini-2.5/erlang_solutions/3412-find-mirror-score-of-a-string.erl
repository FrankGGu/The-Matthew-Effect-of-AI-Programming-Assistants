-module(solution).
-export([mirror_score/1]).

mirror_score(S) ->
    S_rev = lists:reverse(S),
    lists:foldl(fun({C1, C2}, Acc) ->
                        if C1 == C2 -> Acc + 1;
                           true -> Acc
                        end
                end, 0, lists:zip(S, S_rev)).