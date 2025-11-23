-module(solution).
-export([smallest_integer_divisible_by_k/1]).

smallest_integer_divisible_by_k(K) ->
    find_smallest_integer(K, 1).

find_smallest_integer(K, N) ->
    case (N * 10) rem K of
        0 -> N * 10;
        _ -> find_smallest_integer(K, N + 1)
    end.