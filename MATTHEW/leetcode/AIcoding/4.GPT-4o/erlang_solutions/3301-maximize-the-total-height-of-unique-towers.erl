-module(solution).
-export([max_height/1]).

max_height(Blocks) ->
    BlocksSorted = lists:sort(Blocks),
    MaxHeight = lists:foldl(fun(X, Acc) -> Acc + X end, 0, lists:usort(BlocksSorted)),
    MaxHeight.