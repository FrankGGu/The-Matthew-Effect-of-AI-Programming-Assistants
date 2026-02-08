-module(max_points_after_collecting_coins_from_all_nodes).
-export([maxPoints/1]).

maxPoints(Root) ->
    {Max, _} = dfs(Root),
    Max.

dfs(Node) ->
    case Node of
        null -> {0, 0};
        _ ->
            {LeftMax, LeftSum} = dfs(Node#node.left),
            {RightMax, RightSum} = dfs(Node#node.right),
            CurrentSum = Node#node.val + LeftSum + RightSum,
            CurrentMax = max(LeftMax, RightMax) + Node#node.val,
            {CurrentMax, CurrentSum}
    end.