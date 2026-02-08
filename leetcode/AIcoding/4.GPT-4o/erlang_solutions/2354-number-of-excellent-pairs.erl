-module(solution).
-export([countExcellentPairs/2]).

countExcellentPairs(N, nums) ->
    UniqueNums = lists:usort(nums),
    K = length(UniqueNums),
    BitCounts = [count_bits(X) || X <- UniqueNums],
    MaxBitCount = lists:max(BitCounts),
    Count = lists:foldl(fun(C, Acc) -> Acc + (MaxBitCount - C + 1) end, 0, BitCounts),
    Count.

count_bits(X) ->
    erlang:integer_to_binary(X, 2) |> binary_to_list() |> lists:filter(fun(X) -> X == $1 end) |> length().