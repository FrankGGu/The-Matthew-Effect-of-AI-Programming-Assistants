-module(solution).
-export([kth_smallest_instructions/2]).

kth_smallest_instructions([Row, Column], K) ->
    solve(Row, Column, K, []).

solve(0, 0, _K, Acc) ->
    lists:reverse(Acc);
solve(R, 0, _K, Acc) ->
    lists:reverse(Acc) ++ lists:duplicate(R, $V);
solve(0, C, _K, Acc) ->
    lists:reverse(Acc) ++ lists:duplicate(C, $H);
solve(R, C, K, Acc) ->
    PathsStartingWithH = combinations(R + C - 1, R),

    if K =< PathsStartingWithH ->
        solve(R, C - 1, K, [$H | Acc]);
    true ->
        solve(R - 1, C, K - PathsStartingWithH, [$V | Acc])
    end.

combinations(N, K) when K < 0; K > N -> 0;
combinations(N, 0) -> 1;
combinations(N, K) when K == N -> 1;
combinations(N, K) ->
    ActualK = min(K, N - K),
    combinations_iter(0, ActualK, N, 1).

combinations_iter(I, K, N, Result) ->
    if I == K -> Result;
       true ->
            NewResult = Result * (N - I) div (I + 1),
            combinations_iter(I + 1, K, N, NewResult)
    end.