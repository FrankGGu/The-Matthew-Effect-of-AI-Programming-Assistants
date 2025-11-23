-module(subsets_ii).
-export([subsets_diff/1]).

subsets_diff(Nums) ->
    subsets_diff(Nums, []).

subsets_diff([], Acc) ->
    lists:usort(Acc);
subsets_diff(Nums, Acc) ->
    [H | T] = Nums,
    Subsets = subsets_diff(T, [[H | X] || X <- Acc ++ [[]]]),
    subsets_diff(T, Acc ++ Subsets).

subsets_diff([]) ->
    [[]];
subsets_diff(Nums) ->
    Sorted = lists:sort(Nums),
    subsets_diff(Sorted, []).