-module(solution).
-export([solve/2]).

-record(treenode, {val, left = null, right = null}).

solve(Root, Queries) ->
    {Depths, Heights, _} = dfs1(Root, 0, maps:new(), maps:new()),
    AnswersMap = dfs2(Root, -1, Depths, Heights, maps:new()),
    lists:map(fun(QueryVal) -> maps:get(QueryVal, AnswersMap) end, Queries).

dfs1(null, _Depth, DepthsMap, HeightsMap) ->
    {DepthsMap, HeightsMap, -1};
dfs1(Node, Depth, DepthsMap0, HeightsMap0) ->
    #treenode{val = Val, left = Left, right = Right} = Node,
    DepthsMap1 = maps:put(Val, Depth, DepthsMap0),

    {DepthsMap2, HeightsMap1, LeftHeight} = dfs1(Left, Depth + 1, DepthsMap1, HeightsMap0),
    {DepthsMap3, HeightsMap2, RightHeight} = dfs1(Right, Depth + 1, DepthsMap2, HeightsMap1),

    NodeHeight = 1 + max(LeftHeight, RightHeight),
    HeightsMap3 = maps:put(Val, NodeHeight, HeightsMap2),
    {DepthsMap3, HeightsMap3, NodeHeight}.

dfs2(null, _MaxUpVal, _DepthsMap, _HeightsMap, AnswersMap) ->
    AnswersMap;
dfs2(Node, MaxUpVal, DepthsMap, HeightsMap, AnswersMap0) ->
    #treenode{val = Val, left = Left, right = Right} = Node,
    AnswersMap1 = maps:put(Val, MaxUpVal, AnswersMap0),

    CurrentDepth = maps:get(Val, DepthsMap),

    AnswersMap2 =
        case Left of
            null -> AnswersMap1;
            _ ->
                RightHeight =
                    case Right of
                        null -> -1;
                        _ -> maps:get(Right#treenode.val, HeightsMap)
                    end,
                LeftMaxUpVal = max(MaxUpVal + 1, CurrentDepth + 1 + RightHeight),
                dfs2(Left, LeftMaxUpVal, DepthsMap, HeightsMap, AnswersMap1)
        end,

    AnswersMap3 =
        case Right of
            null -> AnswersMap2;
            _ ->
                LeftHeight =
                    case Left of
                        null -> -1;
                        _ -> maps:get(Left#treenode.val, HeightsMap)
                    end,
                RightMaxUpVal = max(MaxUpVal + 1, CurrentDepth + 1 + LeftHeight),
                dfs2(Right, RightMaxUpVal, DepthsMap, HeightsMap, AnswersMap2)
        end,
    AnswersMap3.