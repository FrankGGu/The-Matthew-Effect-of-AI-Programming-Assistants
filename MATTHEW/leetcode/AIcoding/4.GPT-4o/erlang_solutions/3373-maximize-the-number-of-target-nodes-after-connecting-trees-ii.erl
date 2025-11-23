-module(solution).
-export([maxTargetNodes/2]).

maxTargetNodes(Tree1, Tree2) ->
    MaxHeight = max(height(Tree1), height(Tree2)),
    MaxNodes = calculate_max_nodes(MaxHeight),
    MaxNodes.

height(nil) -> 0;
height({_, Left, Right}) -> 1 + max(height(Left), height(Right)).

calculate_max_nodes(Height) -> (1 bsl Height) - 1.