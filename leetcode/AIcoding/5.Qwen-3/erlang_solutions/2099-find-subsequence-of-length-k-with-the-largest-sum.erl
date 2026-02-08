-module(solution).
-export([max_subsequence/2]).

max_subsequence(Nums, K) ->
    Len = length(Nums),
    Indices = lists:seq(0, Len - 1),
    Sorted = lists:sort(fun({A, V}, {B, W}) -> 
        if V > W -> true;
           V == W -> A < B;
           true -> false
        end
    end, [{I, N} || {I, N} <- lists:zip(Indices, Nums)]),
    TopK = lists:sublist(Sorted, K),
    SortedIndices = lists:sort([I || {I, _} <- TopK]),
    [lists:nth(I + 1, Nums) || I <- SortedIndices].