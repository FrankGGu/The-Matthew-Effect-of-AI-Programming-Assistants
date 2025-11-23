-spec target_indices(Nums :: [integer()], Target :: integer()) -> [integer()].
target_indices(Nums, Target) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    [Index || {Element, Index} <- lists:zip(SortedNums, lists:seq(0, Len - 1)),
              Element == Target].