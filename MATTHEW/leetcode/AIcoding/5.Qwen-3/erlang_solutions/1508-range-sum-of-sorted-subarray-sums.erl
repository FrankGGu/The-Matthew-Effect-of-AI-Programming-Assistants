-module(solution).
-export([range_sum/3]).

range_sum(Nums, k, _Mod) ->
    N = length(Nums),
    Sums = generate_subarray_sums(Nums),
    Sorted = lists:sort(Sums),
    Sum = lists:foldl(fun(X, Acc) -> (Acc + X) rem 1000000007 end, 0, lists:sublist(Sorted, k)),
    Sum.

generate_subarray_sums(Nums) ->
    generate_subarray_sums(Nums, 1, []).

generate_subarray_sums([], _, Acc) ->
    Acc;
generate_subarray_sums([H | T], Start, Acc) ->
    SubSums = generate_subarray_sums_from_index(H, T, 1, []),
    generate_subarray_sums(T, Start + 1, Acc ++ SubSums).

generate_subarray_sums_from_index(_, [], _, Acc) ->
    Acc;
generate_subarray_sums_from_index(Current, [H | T], Index, Acc) ->
    NewSum = Current + H,
    generate_subarray_sums_from_index(NewSum, T, Index + 1, Acc ++ [NewSum]).