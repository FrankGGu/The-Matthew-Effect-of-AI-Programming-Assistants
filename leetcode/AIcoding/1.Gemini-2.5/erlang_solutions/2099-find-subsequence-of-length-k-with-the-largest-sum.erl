-spec max_subsequence(Nums :: [integer()], K :: integer()) -> [integer()].
max_subsequence(Nums, K) ->
    IndexedNums = lists:zip(Nums, lists:seq(0, length(Nums) - 1)),

    SortedByNumDesc = lists:sort(fun({N1, _}, {N2, _}) -> N1 >= N2 end, IndexedNums),

    TopKByNum = lists:sublist(SortedByNumDesc, K),

    SortedByIndexAsc = lists:sort(fun({_, I1}, {_, I2}) -> I1 =< I2 end, TopKByNum),

    lists:map(fun({N, _}) -> N end, SortedByIndexAsc).