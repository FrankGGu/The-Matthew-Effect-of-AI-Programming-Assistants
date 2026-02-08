-module(solution).
-export([num_of_ways/1]).

num_of_ways(N) ->
    mod(ways(N, 0), 1000000007).

ways(0, _) -> 1;
ways(1, _) -> 6;
ways(N, 0) -> (ways(N - 1, 1) * 2 + ways(N - 1, 0) * 2) rem 1000000007;
ways(N, 1) -> (ways(N - 1, 0) * 3) rem 1000000007.