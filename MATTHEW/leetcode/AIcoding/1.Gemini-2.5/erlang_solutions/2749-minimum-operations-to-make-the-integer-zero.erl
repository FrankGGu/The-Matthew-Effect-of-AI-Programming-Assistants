-module(solution).
-export([minimumOperations/2]).

minimumOperations(N, K) ->
    solve(N, K, 1).

solve(N, K, Ops) ->
    Target = N - Ops * K,
    if
        Target < Ops -> % If Target is negative or too small to be represented by 'Ops' powers of 2
            -1;
        popcount(Target) =< Ops -> % Check if Target can be formed by 'Ops' powers of 2
            Ops;
        true -> % If popcount(Target) > Ops, try with more operations
            solve(N, K, Ops + 1)
    end.

popcount(0) -> 0;
popcount(N) when N > 0 ->
    popcount_recursive(N, 0).

popcount_recursive(0, Count) -> Count;
popcount_recursive(N, Count) ->
    popcount_recursive(N band (N - 1), Count + 1).