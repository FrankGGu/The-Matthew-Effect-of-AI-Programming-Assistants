-module(solution).
-export([levelOrderBottom/1]).

-record('TreeNode', {val, left, right}).

levelOrderBottom(nil) ->
    [];
levelOrderBottom(Root) ->
    Q = queue:in(Root, queue:new()),
    levelOrderBottom_bfs(Q, []).

levelOrderBottom_bfs(Q, Acc) when queue:is_empty(Q) ->
    Acc;
levelOrderBottom_bfs(Q, Acc) ->
    LevelSize = queue:len(Q),
    {CurrentLevelNodesReversed, NewQ} = process_level(Q, LevelSize, [], queue:new()),
    CurrentLevelNodes = lists:reverse(CurrentLevelNodesReversed),
    levelOrderBottom_bfs(NewQ, [CurrentLevelNodes | Acc]).

process_level(Q, 0, CurrentLevelNodesReversed, NewQ) ->
    {CurrentLevelNodesReversed, NewQ};
process_level(Q, Count, CurrentLevelNodesReversed, NewQAcc) ->
    {ok, Node, RestQ} = queue:out(Q),
    Val = Node#'TreeNode'.val,
    Left = Node#'TreeNode'.left,
    Right = Node#'TreeNode'.right,

    NextNewQAcc = case Left of
                      nil -> NewQAcc;
                      _ -> queue:in(Left, NewQAcc)
                  end,
    NextNewQAcc2 = case Right of
                       nil -> NextNewQAcc;
                       _ -> queue:in(Right, NextNewQAcc)
                   end,
    process_level(RestQ, Count - 1, [Val | CurrentLevelNodesReversed], NextNewQAcc2).