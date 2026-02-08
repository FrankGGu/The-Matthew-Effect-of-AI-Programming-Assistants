-module(solution).
-export([countSubTrees/3]).

build_adj(N, Edges) ->
    Adj = array:new(N, {default, []}),
    lists:foldl(fun([U, V], Acc) ->
        Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
        array:set(V, [U | array:get(V, Acc1)], Acc1)
    end, Adj, Edges).

merge_maps(Map1, Map2) ->
    maps:fold(fun(K, V, Acc) ->
        maps:update_with(K, fun(OldV) -> OldV + V end, V, Acc)
    end, Map1, Map2).

dfs(Node, Parent, Adj, LabelsArr, AnsMapAcc) ->
    LabelChar = array:get(Node, LabelsArr),

    CountsMap = maps:new(),
    CountsMap1 = maps:update_with(LabelChar, fun(V) -> V + 1 end, 1, CountsMap),

    Neighbors = array:get(Node, Adj),

    {SubtreeCountsMap, FinalAnsMapAcc} = lists:foldl(fun(Child, {AccCountsMap, AccAnsMap}) ->
        if Child == Parent ->
            {AccCountsMap, AccAnsMap};
        true ->
            {ChildCountsMap, UpdatedChildAnsMap} = dfs(Child, Node, Adj, LabelsArr, AccAnsMap),
            {merge_maps(AccCountsMap, ChildCountsMap), UpdatedChildAnsMap}
        end
    end, {CountsMap1, AnsMapAcc}, Neighbors),

    CurrentNodeLabelCount = maps:get(LabelChar, SubtreeCountsMap, 0),

    UpdatedAnsMapForCurrentNode = maps:put(Node, CurrentNodeLabelCount, FinalAnsMapAcc),

    {SubtreeCountsMap, UpdatedAnsMapForCurrentNode}.

countSubTrees(N, Edges, LabelsStr) ->
    Adj = build_adj(N, Edges),
    LabelsArr = array:from_list(string:to_list(LabelsStr)),
    AnsMap = maps:new(),

    {_FinalSubtreeCountsMap, FinalAnsMap} = dfs(0, -1, Adj, LabelsArr, AnsMap),

    SortedPairs = lists:sort(fun({K1, _}, {K2, _}) -> K1 =< K2 end, maps:to_list(FinalAnsMap)),
    lists:map(fun({_K, V}) -> V end, SortedPairs).