-module(solution).
-export([maximumBalancedSubsequenceSum/1]).

maximumBalancedSubsequenceSum(Nums) ->
    N = length(Nums),
    if N == 0 ->
        0;
    true ->
        IndexedNums = lists:zip(Nums, lists:seq(0, N-1)),
        Vals = lists:map(fun({Num, I}) -> Num - I end, IndexedNums),
        UniqueSortedVals = lists:usort(Vals),

        ValToCompressedIdx = maps:from_list(lists:zip(UniqueSortedVals, lists:seq(0, length(UniqueSortedVals)-1))),

        M = length(UniqueSortedVals),

        TreeSize = power_of_2_ceil(M),

        SegmentTree = array:new([{size, 2 * TreeSize}, {fixed, true}, {default, 0}]),

        FinalSegmentTree = lists:foldl(
            fun({Num, I}, AccTree) ->
                Val = Num - I,
                CompressedIdx = maps:get(Val, ValToCompressedIdx),

                MaxPrevSum = query_segment_tree(AccTree, 1, 0, TreeSize-1, 0, CompressedIdx),

                CurrentSum = MaxPrevSum + Num,

                update_segment_tree(AccTree, 1, 0, TreeSize-1, CompressedIdx, CurrentSum)
            end,
            SegmentTree,
            IndexedNums
        ),

        query_segment_tree(FinalSegmentTree, 1, 0, TreeSize-1, 0, M-1)
    end.

power_of_2_ceil(N) ->
    power_of_2_ceil(N, 1).
power_of_2_ceil(N, Acc) when Acc >= N -> Acc;
power_of_2_ceil(N, Acc) -> power_of_2_ceil(N, Acc * 2).

query_segment_tree(Tree, NodeIdx, NodeLow, NodeHigh, QueryLow, QueryHigh) ->
    if NodeLow > QueryHigh; NodeHigh < QueryLow ->
        0;
    NodeLow >= QueryLow andalso NodeHigh <= QueryHigh ->
        array:get(NodeIdx-1, Tree);
    true ->
        Mid = NodeLow + (NodeHigh - NodeLow) div 2,
        LeftChild = NodeIdx * 2,
        RightChild = NodeIdx * 2 + 1,
        LeftMax = query_segment_tree(Tree, LeftChild, NodeLow, Mid, QueryLow, QueryHigh),
        RightMax = query_segment_tree(Tree, RightChild, Mid + 1, NodeHigh, QueryLow, QueryHigh),
        erlang:max(LeftMax, RightMax)
    end.

update_segment_tree(Tree, NodeIdx, NodeLow, NodeHigh, TargetIdx, NewVal) ->
    if NodeLow == NodeHigh ->
        CurrentVal = array:get(NodeIdx-1, Tree),
        array:set(NodeIdx-1, erlang:max(CurrentVal, NewVal), Tree);
    true ->
        Mid = NodeLow + (NodeHigh - NodeLow) div 2,
        LeftChild = NodeIdx * 2,
        RightChild = NodeIdx * 2 + 1,
        UpdatedTree = 
            if TargetIdx <= Mid ->
                update_segment_tree(Tree, LeftChild, NodeLow, Mid, TargetIdx, NewVal);
            true ->
                update_segment_tree(Tree, RightChild, Mid + 1, NodeHigh, TargetIdx, NewVal)
            end,
        LeftMax = array:get(LeftChild-1, UpdatedTree),
        RightMax = array:get(RightChild-1, UpdatedTree),
        array:set(NodeIdx-1, erlang:max(LeftMax, RightMax), UpdatedTree)
    end.