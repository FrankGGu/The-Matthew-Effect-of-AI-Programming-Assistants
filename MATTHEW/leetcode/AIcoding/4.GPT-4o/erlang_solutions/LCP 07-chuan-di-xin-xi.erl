-module(solution).
-export([num_ways/2]).

num_ways(N, K) ->
    num_ways(N, K, 0).

num_ways(0, _, _) -> 1;
num_ways(N, K, Last) when N > 0 ->
    lists:sum(
        [num_ways(N - 1, K, X) || X <- lists:seq(1, K), X =/= Last]
    ).