-module(maximum_subsequence_score).
-export([max_score/2]).

max_score(Numbers, K) ->
    lists:reverse(lists:sort([lists:sum([element(I, Numbers) || I <- Indices]) || Indices <- combinations(length(Numbers), K)])).

combinations(N, 0) -> [[]];
combinations(N, K) when K == N -> [lists:seq(1, N)];
combinations(N, K) ->
    [ [H | T] || H <- lists:seq(1, N),
                T <- combinations(N - 1, K - 1) ] ++
    [ T || T <- combinations(N - 1, K) ].