-module(solution).
-export([right_side_view/1]).

-record(tree_node, {val, left, right}).

right_side_view(undefined) -> [];
right_side_view(Root) ->
    bfs([Root], []).

bfs([], Result) -> lists:reverse(Result);
bfs(Queue, Result) ->
    {LastNode, _} = lists:last(Queue),
    NewResult = [LastNode#tree_node.val | Result],
    NextLevel = lists:flatmap(fun(Node) ->
        lists:flatten([Node#tree_node.left, Node#tree_node.right])
    end, Queue),
    bfs(NextLevel, NewResult).