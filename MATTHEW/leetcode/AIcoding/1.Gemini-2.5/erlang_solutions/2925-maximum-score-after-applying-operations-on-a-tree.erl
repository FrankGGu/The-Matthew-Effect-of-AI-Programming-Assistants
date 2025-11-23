-module(solution).
-export([maximum_score_after_operations_on_tree/2]).

maximum_score_after_operations_on_tree(Parents, Values) ->
    N = length(Parents),
    AdjList = build_adj_list(Parents, N),
    ValuesArray = array:from_list(Values),
    {Include0, Exclude0} = dfs(0, AdjList, ValuesArray),
    max(Include0, Exclude0).

build_adj_list(Parents, N) ->
    Adj = array:new(N, {default, []}),
    lists:foldl(
        fun(NodeIdx, AccAdj) ->
            ParentIdx = lists:nth(NodeIdx + 1, Parents),
            if ParentIdx == -1 ->
                AccAdj;
            true ->
                ChildrenOfParent = array:get(ParentIdx, AccAdj),
                array:set(ParentIdx, [NodeIdx | ChildrenOfParent], AccAdj)
            end
        end,
        Adj,
        lists:seq(0, N-1)
    ).

dfs(U, AdjList, ValuesArray) ->
    Children = array:get(U, AdjList),
    if Children == [] ->
        IncludeU = array:get(U, ValuesArray),
        ExcludeU = 0,
        {IncludeU, ExcludeU};
    true ->
        {SumExcludeChildren, SumMaxChildren} = lists:foldl(
            fun(Child, {AccExclude, AccMax}) ->
                {ChildInclude, ChildExclude} = dfs(Child, AdjList, ValuesArray),
                {AccExclude + ChildExclude, AccMax + max(ChildInclude, ChildExclude)}
            end,
            {0, 0},
            Children
        ),
        ValueU = array:get(U, ValuesArray),
        IncludeU = ValueU + SumExcludeChildren,
        ExcludeU = SumMaxChildren,
        {IncludeU, ExcludeU}
    end.