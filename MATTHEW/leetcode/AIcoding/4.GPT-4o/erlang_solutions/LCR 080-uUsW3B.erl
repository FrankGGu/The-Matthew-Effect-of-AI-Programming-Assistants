-module(solution).
-export([combine/2]).

combine(N, K) ->
    combine(N, K, 1, []).

combine(_, 0, _, Acc) -> 
    [lists:reverse(Acc)];
combine(N, K, Start, Acc) when Start =< N ->
    combine(N, K - 1, Start + 1, [Start | Acc]) ++
    combine(N, K, Start + 1, Acc);
combine(_, _, _, _) -> 
    [].