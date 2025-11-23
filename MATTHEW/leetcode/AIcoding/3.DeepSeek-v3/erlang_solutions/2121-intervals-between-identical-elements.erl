-spec get_distances(Arr :: [integer()]) -> [integer()].
get_distances(Arr) ->
    IndexMap = lists:foldl(fun(Val, {I, Map}) ->
        case maps:find(Val, Map) of
            {ok, Indices} -> {I + 1, maps:put(Val, [I | Indices], Map)};
            error -> {I + 1, maps:put(Val, [I], Map)}
        end
    end, {0, maps:new()}, Arr),
    {_, IndicesMap} = IndexMap,
    maps:fold(fun(_, Indices, AccMap) ->
        SortedIndices = lists:sort(Indices),
        Prefix = lists:foldl(fun(Idx, {Sum, List}) ->
            NewSum = Sum + Idx,
            {NewSum, [NewSum | List]}
        end, {0, []}, SortedIndices),
        {PrefixSum, _} = Prefix,
        Suffix = lists:foldr(fun(Idx, {Sum, List}) ->
            NewSum = Sum + Idx,
            {NewSum, [NewSum | List]}
        end, {0, []}, SortedIndices),
        {SuffixSum, _} = Suffix,
        lists:foldl(fun({Pos, Idx}, Acc) ->
            Left = Idx * (Pos + 1) - lists:nth(Pos + 1, PrefixSum),
            Right = (lists:nth(length(SuffixSum) - Pos, SuffixSum)) - Idx * (length(SuffixSum) - Pos - 1),
            maps:put(Idx, Left + Right, Acc)
        end, AccMap, lists:zip(lists:seq(0, length(SortedIndices) - 1), SortedIndices))
    end, maps:new(), IndicesMap),
    lists:map(fun(Val) -> maps:get(Val, maps:get(Val, IndicesMap)) end, Arr).