-module(solution).
-export([average_of_levels/1]).

-record('TreeNode', {val, left, right}).

average_of_levels(Root) ->
    case Root of
        nil -> [];
        _   -> bfs_helper([Root], [])
    end.

bfs_helper([], AccAverages) ->
    lists:reverse(AccAverages);
bfs_helper(CurrentLevelNodes, AccAverages) ->
    {LevelSum, LevelCount, NextLevelNodesReversed} = process_level_nodes(CurrentLevelNodes, 0, 0, []),
    Average = LevelSum / LevelCount,
    bfs_helper(lists:reverse(NextLevelNodesReversed), [Average | AccAverages]).

process_level_nodes([], Sum, Count, NextLevelNodesAcc) ->
    {Sum, Count, NextLevelNodesAcc};
process_level_nodes([#'TreeNode'{val=Val, left=Left, right=Right} | Rest], Sum, Count, NextLevelNodesAcc) ->
    NewSum = Sum + Val,
    NewCount = Count + 1,

    NextLevelNodesAcc1 = case Left of
                             nil -> NextLevelNodesAcc;
                             _   -> [Left | NextLevelNodesAcc]
                         end,
    NextLevelNodesAcc2 = case Right of
                             nil -> NextLevelNodesAcc1;
                             _   -> [Right | NextLevelNodesAcc1]
                         end,

    process_level_nodes(Rest, NewSum, NewCount, NextLevelNodesAcc2).