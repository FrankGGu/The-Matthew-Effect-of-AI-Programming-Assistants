-module(leetcode).
-export([findMode/1]).

findMode(nil) -> [];
findMode(Root) ->
    %% Pass 1: Find the maximum frequency (MaxCount)
    %% State: {PrevVal, PrevCount, MaxCount}
    %% Initialize PrevVal to a value outside the possible node value range [-10^5, 10^5]
    InitialStatePass1 = {-100001, 0, 0},
    {_, _, MaxCount} = inorder_find_max_count(Root, InitialStatePass1),

    %% Pass 2: Collect all values that have the MaxCount
    %% State: {PrevVal, PrevCount, TargetMaxCount, ModesList}
    InitialStatePass2 = {-100001, 0, MaxCount, []},
    {_, _, _, Modes} = inorder_collect_modes(Root, InitialStatePass2),

    Modes.

inorder_find_max_count(nil, Acc) -> Acc;
inorder_find_max_count({val, Val, Left, Right}, {PrevVal, PrevCount, MaxCount}) ->
    %% Traverse left subtree
    {L_PrevVal, L_PrevCount, L_MaxCount} = inorder_find_max_count(Left, {PrevVal, PrevCount, MaxCount}),

    %% Process current node
    NewCount = if Val == L_PrevVal -> L_PrevCount + 1;
                 true             -> 1
               end,
    NewMaxCount = max(L_MaxCount, NewCount),

    %% Traverse right subtree
    inorder_find_max_count(Right, {Val, NewCount, NewMaxCount}).

inorder_collect_modes(nil, Acc) -> Acc;
inorder_collect_modes({val, Val, Left, Right}, {PrevVal, PrevCount, TargetMaxCount, Modes}) ->
    %% Traverse left subtree
    {L_PrevVal, L_PrevCount, L_TargetMaxCount, L_Modes} = inorder_collect_modes(Left, {PrevVal, PrevCount, TargetMaxCount, Modes}),

    %% Process current node
    NewCount = if Val == L_PrevVal -> L_PrevCount + 1;
                 true             -> 1
               end,

    NewModes = if NewCount == L_TargetMaxCount -> [Val | L_Modes];
                  true                     -> L_Modes
               end,

    %% Traverse right subtree
    inorder_collect_modes(Right, {Val, NewCount, L_TargetMaxCount, NewModes}).