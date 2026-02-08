-module(solution).
-export([find_frequent_tree_sum/1]).

%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(), left = null  :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

%% Find the most frequent subtree sum
-spec find_frequent_tree_sum(#tree_node{} | null) -> [integer()].
find_frequent_tree_sum(Root) ->
    %% Initialize the frequency map
    {FreqMap, _} = find_sums(Root, #{}),
    %% Find the most frequent sums
    MaxFreq = lists:max(maps:values(FreqMap)),
    %% Filter sums that match the max frequency
    lists:filter(fun(Sum) -> maps:get(Sum, FreqMap, 0) == MaxFreq end, maps:keys(FreqMap)).

%% Helper function to calculate subtree sums and their frequencies
-spec find_sums(#tree_node{} | null, maps:map()) -> {maps:map(), integer()}.
find_sums(null, FreqMap) ->
    {FreqMap, 0};
find_sums(#tree_node{val = Val, left = Left, right = Right}, FreqMap) ->
    {LeftSumMap, LeftSum} = find_sums(Left, FreqMap),
    {RightSumMap, RightSum} = find_sums(Right, LeftSumMap),
    SubtreeSum = Val + LeftSum + RightSum,
    UpdatedMap = maps:insert_with(fun(_, Old, New) -> Old + New end, SubtreeSum, 1, RightSumMap),
    {UpdatedMap, SubtreeSum}.
