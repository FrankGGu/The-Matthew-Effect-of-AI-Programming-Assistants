-record('TreeNode', {val, left, right}).

-spec zigzagLevelOrder('TreeNode'{} | nil) -> [[integer()]].
zigzagLevelOrder(nil) ->
    [];
zigzagLevelOrder(Root) ->
    bfs([Root], [], 0).

bfs([], Acc, _Level) ->
    lists:reverse(Acc);
bfs(NodesAtCurrentLevel, Acc, Level) ->
    CurrentLevelVals = [N#TreeNode.val || N <- NodesAtCurrentLevel],

    NextLevelNodes = lists:foldl(
        fun(Node, AccNodes) ->
            AccWithLeft = case Node#TreeNode.left of
                              nil -> AccNodes;
                              Left -> [Left | AccNodes]
                          end,
            case Node#TreeNode.right of
                nil -> AccWithLeft;
                Right -> [Right | AccWithLeft]
            end
        end,
        [],
        NodesAtCurrentLevel
    ),

    NextLevelNodesOrdered = lists:reverse(NextLevelNodes),

    ProcessedCurrentLevelVals = case Level rem 2 of
                                    0 -> CurrentLevelVals;
                                    1 -> lists:reverse(CurrentLevelVals)
                                end,

    bfs(NextLevelNodesOrdered, [ProcessedCurrentLevelVals | Acc], Level + 1).