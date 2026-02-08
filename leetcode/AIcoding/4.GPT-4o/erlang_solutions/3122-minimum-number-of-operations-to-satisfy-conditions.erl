-module(solution).
-export([min_operations/2]).

min_operations(N, K) ->
    min_operations_helper(N, K, 0).

min_operations_helper(0, 0, Ops) -> Ops;
min_operations_helper(N, K, Ops) when N > 0, K > 0 ->
    min_operations_helper(N - 1, K - 1, Ops + 1);
min_operations_helper(N, K, Ops) when N > 0 ->
    min_operations_helper(N - 1, K, Ops + 1);
min_operations_helper(N, K, Ops) when K > 0 ->
    min_operations_helper(N, K - 1, Ops + 1);
min_operations_helper(0, K, Ops) -> Ops + K;
min_operations_helper(N, 0, Ops) -> Ops + N.