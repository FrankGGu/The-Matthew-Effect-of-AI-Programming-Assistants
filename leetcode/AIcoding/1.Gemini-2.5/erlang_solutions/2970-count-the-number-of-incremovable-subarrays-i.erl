-module(solution).
-export([count_incremovable_subarrays/1]).

is_strictly_increasing([]) -> true;
is_strictly_increasing([_]) -> true;
is_strictly_increasing([H1, H2 | T]) ->
    H1 < H2 andalso is_strictly_increasing([H2 | T]).

count_incremovable_subarrays(Nums) ->
    N = length(Nums),
    count_incremovable_subarrays_loop_i(Nums, N, 0, 0).

count_incremovable_subarrays_loop_i(Nums, N, I, Count) when I < N ->
    count_incremovable_subarrays_loop_j(Nums, N, I, I, Count);
count_incremovable_subarrays_loop_i(_Nums, _N, _I, Count) ->
    Count.

count_incremovable_subarrays_loop_j(Nums, N, I, J, Count) when J < N ->
    Prefix = lists:sublist(Nums, 1, I),
    SuffixLen = N - (J + 1),
    Suffix = lists:sublist(Nums, J + 2, SuffixLen),

    Remaining = Prefix ++ Suffix,

    NewCount = if is_strictly_increasing(Remaining) -> Count + 1;
                 true -> Count
               end,

    count_incremovable_subarrays_loop_j(Nums, N, I, J + 1, NewCount);
count_incremovable_subarrays_loop_j(Nums, N, I, _J, Count) ->
    count_incremovable_subarrays_loop_i(Nums, N, I + 1, Count).