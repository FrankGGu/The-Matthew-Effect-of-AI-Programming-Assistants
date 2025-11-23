-module(solution).
-export([average_of_levels/1]).

-record(node, {val, left = null, right = null}).

average_of_levels(Root) ->
    {Levels, Count} = bfs([Root], [], 0),
    lists:map(fun({Sum, C}) -> Sum / C end, lists:zip(Levels, Count)).

bfs([], Levels, _) -> {Levels, []};
bfs(Nodes, Levels, Level) ->
    {Sum, Count} = lists:foldl(fun(Node, {SumAcc, CountAcc}) ->
        {SumAcc + Node#node.val, CountAcc + 1}
    end, {0, 0}, Nodes),
    NextNodes = lists:flatmap(fun(Node) -> [Node#node.left, Node#node.right] end, Nodes),
    bfs(NextNodes, Levels ++ [{Sum, Count}], Level + 1).