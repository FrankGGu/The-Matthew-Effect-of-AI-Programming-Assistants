-module(solution).
-export([longest_subarray/1]).

longest_subarray(A) ->
    N = length(A),
    {IncreasingLength, DecreasingLength} = longest_subarray_helper(A, N, 1, 1, 1),
    max(IncreasingLength, DecreasingLength).

longest_subarray_helper([], _, Inc, Dec, Max) ->
    Max;
longest_subarray_helper([_], _, Inc, Dec, Max) ->
    Max;
longest_subarray_helper([H1, H2 | T], N, Inc, Dec, Max) when H1 < H2 ->
    longest_subarray_helper([H2 | T], N, Inc + 1, 1, max(Max, Inc + 1));
longest_subarray_helper([H1, H2 | T], N, Inc, Dec, Max) when H1 > H2 ->
    longest_subarray_helper([H2 | T], N, 1, Dec + 1, max(Max, Dec + 1));
longest_subarray_helper([H1, H2 | T], N, Inc, Dec, Max) ->
    longest_subarray_helper([H2 | T], N, 1, 1, max(Max, max(Inc, Dec))).