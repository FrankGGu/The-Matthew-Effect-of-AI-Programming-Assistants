-module(solution).
-export([max_level_sum/1]).

-spec max_level_sum(Root :: any()) -> integer().
max_level_sum(nil) ->
    %% According to problem constraints, the number of nodes is in the range [1, 10^4],
    %% so the tree is never empty. This case is for completeness.
    0;
max_level_sum({node, Val, Left, Right} = Root) ->
    %% Start BFS with the root node in the queue.
    %% Initial max_sum is the root's value, initial max_level is 1.
    bfs([{node, Val, Left, Right}], 1, Val, 1).

-spec bfs(list(), integer(), integer(), integer()) -> integer().
bfs([], _CurrentLevel, _CurrentMaxSum, CurrentMaxLevel) ->
    %% If the queue is empty, BFS is complete. Return the recorded max level.
    CurrentMaxLevel;
bfs(Queue, CurrentLevel, CurrentMaxSum, CurrentMaxLevel) ->
    %% Process all nodes at the current level.
    %% This returns the sum of values for the current level and a list of children
    %% for the next level's queue.
    {LevelSum, NextQueue} = process_level(Queue),

    %% Update MaxSum and MaxLevel if the current level's sum is greater.
    NewMaxSum = max(CurrentMaxSum, LevelSum),
    NewMaxLevel = if LevelSum > CurrentMaxSum -> CurrentLevel;
                     true -> CurrentMaxLevel
                  end,

    %% Continue BFS with the next level.
    bfs(NextQueue, CurrentLevel + 1, NewMaxSum, NewMaxLevel).

-spec process_level(list()) -> {integer(), list()}.
process_level(Nodes) ->
    %% Helper function to accumulate sum and children efficiently.
    %% Children are accumulated in reverse order and then reversed once at the end.
    process_level(Nodes, 0, []).

-spec process_level(list(), integer(), list()) -> {integer(), list()}.
process_level([], Sum, NextLevelNodesRev) ->
    %% All nodes at the current level processed. Reverse the accumulated children.
    {Sum, lists:reverse(NextLevelNodesRev)};
process_level([{node, Val, Left, Right} | Rest], Sum, NextLevelNodesRev) ->
    %% Add children of the current node to the accumulator.
    NewNextLevelNodesRev = add_children_rev(Left, Right, NextLevelNodesRev),
    %% Recurse for the rest of the nodes at this level.
    process_level(Rest, Sum + Val, NewNextLevelNodesRev).

-spec add_children_rev(any(), any(), list()) -> list().
add_children_rev(nil, nil, Acc) -> Acc;
add_children_rev(nil, {node, _, _, _} = Right, Acc) -> [Right | Acc];
add_children_rev({node, _, _, _} = Left, nil, Acc) -> [Left | Acc];
add_children_rev({node, _, _, _} = Left, {node, _, _, _} = Right, Acc) -> [Right, Left | Acc].