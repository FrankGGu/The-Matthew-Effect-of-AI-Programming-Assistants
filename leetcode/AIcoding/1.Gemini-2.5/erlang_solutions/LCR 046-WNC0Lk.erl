-record('TreeNode', {val, left, right}).

-export([right_side_view/1]).

right_side_view(nil) -> [];
right_side_view(Root) ->
    bfs_level([Root], []).

bfs_level([], Acc) -> lists:reverse(Acc);
bfs_level(CurrentLevelNodes, Acc) ->
    LastNode = lists:last(CurrentLevelNodes),
    NewAcc = [LastNode#'TreeNode'.val | Acc],

    NextLevelNodes = lists:flatmap(
        fun(#'TreeNode'{left = L, right = R}) ->
            case {L, R} of
                {nil, nil} -> [];
                {nil, RightNode} -> [RightNode];
                {LeftNode, nil} -> [LeftNode];
                {LeftNode, RightNode} -> [LeftNode, RightNode]
            end
        end,
        CurrentLevelNodes
    ),
    bfs_level(NextLevelNodes, NewAcc).