-module(solution).
-export([get_minimum_difference/1]).

-record(tree_node, {val = 0, left = null, right = null}).

%% get_minimum_difference/1 returns the minimum absolute difference
-spec get_minimum_difference(#tree_node{} | null) -> integer().
get_minimum_difference(Root) ->
    %% Start an in-order traversal and collect node values
    Values = in_order_traversal(Root, []),
    %% Compute the minimum difference between adjacent values
    min_diff(Values).

%% In-order traversal to get the nodes' values in sorted order
-spec in_order_traversal(#tree_node{} | null, [integer()]) -> [integer()].
in_order_traversal(null, Acc) -> Acc;
in_order_traversal(#tree_node{val=Val, left=Left, right=Right}, Acc) ->
    LeftValues = in_order_traversal(Left, Acc),
    RightValues = in_order_traversal(Right, LeftValues),
    [Val | RightValues].

%% Helper function to calculate the minimum difference between adjacent values
-spec min_diff([integer()]) -> integer().
min_diff([_]) -> 0; %% Base case: if there's only one element
min_diff([A, B | Rest]) ->
    Min = abs(A - B),
    MinRest = min_diff([B | Rest]),
    min(Min, MinRest).

%% Call get_minimum_difference with the tree root node to find the minimum absolute difference.
