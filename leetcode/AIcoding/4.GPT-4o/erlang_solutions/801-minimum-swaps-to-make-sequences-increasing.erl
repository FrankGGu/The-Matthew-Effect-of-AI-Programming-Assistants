-module(solution).
-export([min_swaps/2]).

min_swaps(A, B) ->
    N = length(A),
    min_swaps_helper(A, B, 0, 0, N).

min_swaps_helper(_, _, 0, Min, _) -> Min;
min_swaps_helper(A, B, 1, Min, N) ->
    min_swaps_helper(A, B, 0, Min + 1, N);
min_swaps_helper(A, B, 0, Min, N) ->
    case swap_possible(A, B, Min, N) of
        true -> min_swaps_helper(A, B, 1, Min, N);
        false -> min_swaps_helper(A, B, 0, Min, N)
    end.

swap_possible(A, B, Min, N) ->
    lists:all(fun(I) -> 
        I == N orelse (lists:nth(I, A) < lists:nth(I + 1, A) andalso lists:nth(I, B) < lists:nth(I + 1, B))
    end, lists:seq(1, N - 1)).