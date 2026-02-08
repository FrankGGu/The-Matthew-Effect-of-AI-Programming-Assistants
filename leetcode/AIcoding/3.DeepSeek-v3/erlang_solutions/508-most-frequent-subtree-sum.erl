-spec find_frequent_tree_sum(Root :: #tree_node{} | null) -> [integer()].
find_frequent_tree_sum(Root) ->
    case Root of
        null -> [];
        _ ->
            SumMap = maps:new(),
            {_, SumMap1} = subtree_sum(Root, SumMap),
            MaxFreq = max_frequency(SumMap1),
            maps:fold(fun(K, V, Acc) when V == MaxFreq -> [K | Acc];
                         (_, _, Acc) -> Acc
                      end, [], SumMap1)
    end.

subtree_sum(#tree_node{val = Val, left = Left, right = Right}, SumMap) ->
    {LeftSum, SumMap1} = case Left of
        null -> {0, SumMap};
        _ -> subtree_sum(Left, SumMap)
    end,
    {RightSum, SumMap2} = case Right of
        null -> {0, SumMap1};
        _ -> subtree_sum(Right, SumMap1)
    end,
    Sum = Val + LeftSum + RightSum,
    NewSumMap = maps:update_with(Sum, fun(V) -> V + 1 end, 1, SumMap2),
    {Sum, NewSumMap}.

max_frequency(SumMap) ->
    maps:fold(fun(_, V, Max) -> max(V, Max) end, 0, SumMap).