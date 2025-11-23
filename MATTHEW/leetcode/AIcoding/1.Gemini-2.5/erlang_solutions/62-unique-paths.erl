-module(solution).
-export([uniquePaths/2]).

uniquePaths(M, N) ->
    TotalSteps = M + N - 2,
    K = min(M - 1, N - 1),
    combinations(TotalSteps, K, 1, 1).

combinations(N, K, Num, Den) when K > 0 ->
    combinations(N - 1, K - 1, Num * N, Den * K);
combinations(_, 0, Num, Den) ->
    Num div Den.