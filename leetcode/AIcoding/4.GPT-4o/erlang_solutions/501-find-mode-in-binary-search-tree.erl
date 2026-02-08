%% Definition for a binary tree node
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec find_mode(#tree_node{} | 'null') -> [integer()].
find_mode('null') -> [];
find_mode(Root) ->
    {Modes, _, _} = find_mode_helper(Root, nil, 0, [], 0),
    Modes.

-spec find_mode_helper(#tree_node{}, integer(), integer(), [integer()], integer()) -> {[integer()], integer(), integer()}.
find_mode_helper('null', _, _, Modes, _) -> {Modes, 0, 0};
find_mode_helper(#tree_node{val = Val, left = Left, right = Right}, PrevVal, PrevCount, Modes, MaxCount) ->
    %% Traverse the left subtree
    {LeftModes, LeftMaxCount, LeftMaxValue} = find_mode_helper(Left, PrevVal, PrevCount, Modes, MaxCount),
    %% Update current node mode count
    NewCount = case PrevVal of
                 Val -> PrevCount + 1;
                 _ -> 1
               end,
    %% Update mode list and max count
    {CurrentModes, CurrentMaxCount} = case NewCount of
                                        _ when NewCount > LeftMaxCount ->
                                            {[Val], NewCount};
                                        _ when NewCount == LeftMaxCount ->
                                            {LeftModes ++ [Val], LeftMaxCount};
                                        _ -> {LeftModes, LeftMaxCount}
                                      end,
    %% Traverse the right subtree
    {RightModes, RightMaxCount, RightMaxValue} = find_mode_helper(Right, Val, NewCount, CurrentModes, CurrentMaxCount),
    %% Return final modes
    case RightMaxCount >= LeftMaxCount of
        true -> {RightModes, RightMaxCount, RightMaxValue};
        false -> {CurrentModes, CurrentMaxCount, LeftMaxValue}
    end.
