-spec max_subsequence(Nums :: [integer()], K :: integer()) -> [integer()].
max_subsequence(Nums, K) ->
    Indices = lists:seq(0, length(Nums) - 1),
    Sorted = lists:sort(fun(I, J) -> lists:nth(I + 1, Nums) >= lists:nth(J + 1, Nums) end, Indices),
    Selected = lists:sublist(Sorted, K),
    SortedSelected = lists:sort(Selected),
    [lists:nth(I + 1, Nums) || I <- SortedSelected].