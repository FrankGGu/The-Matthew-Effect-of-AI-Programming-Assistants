-module(solution).
-export([longestZigZag/1]).

longestZigZag(Root) ->
    {_, _, MaxLen} = dfs(Root),
    MaxLen.

dfs(null) ->
    {-1, -1, 0}; % {LeftPathLen, RightPathLen, MaxOverallPathLenInSubtree}
                 % -1 indicates no valid path of this type from an empty node.
                 % 0 for MaxOverallPathLenInSubtree is correct for an empty tree (length 0).
dfs({_Val, Left, Right}) ->
    {LL, LR, LM} = dfs(Left),   % LL: Longest zigzag path from Left ending going left
                                % LR: Longest zigzag path from Left ending going right
                                % LM: Max overall zigzag path in Left subtree
    {RL, RR, RM} = dfs(Right),  % RL: Longest zigzag path from Right ending going left
                                % RR: Longest zigzag path from Right ending going right
                                % RM: Max overall zigzag path in Right subtree

    % Calculate path starting from current node and going left
    % This path continues the "right" path from its left child
    CurrentLeftPath = 1 + RR,

    % Calculate path starting from current node and going right
    % This path continues the "left" path from its right child
    CurrentRightPath = 1 + LL,

    % The maximum zigzag path in the current subtree is the maximum of:
    % 1. The max path found in the left subtree (LM)
    % 2. The max path found in the right subtree (RM)
    % 3. The path starting from current node and going left (CurrentLeftPath)
    % 4. The path starting from current node and going right (CurrentRightPath)
    MaxOverallPath = lists:max([LM, RM, CurrentLeftPath, CurrentRightPath]),

    {CurrentLeftPath, CurrentRightPath, MaxOverallPath}.