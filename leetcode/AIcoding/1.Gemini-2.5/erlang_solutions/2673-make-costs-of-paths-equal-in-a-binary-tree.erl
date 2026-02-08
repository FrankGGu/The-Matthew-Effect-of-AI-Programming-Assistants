-module(solution).
-export([make_costs_equal_in_binary_tree/2]).

make_costs_equal_in_binary_tree(N, CostList) ->
    CostArray = array:from_list(CostList),
    MaxPathSums = array:new(N),
    make_costs_equal_in_binary_tree_impl(N - 1, N, CostArray, MaxPathSums, 0).

make_costs_equal_in_binary_tree_impl(-1, _N, _CostArray, _MaxPathSums, TotalIncrements) ->
    TotalIncrements;
make_costs_equal_in_binary_tree_impl(I, N, CostArray, AccMaxPathSums, AccTotalIncrements) ->
    LeftChild = 2 * I + 1,
    RightChild = 2 * I + 2,
    CurrentCost = array:get(I, CostArray),

    if
        LeftChild >= N ->
            NewAccMaxPathSums = array:set(I, CurrentCost, AccMaxPathSums),
            make_costs_equal_in_binary_tree_impl(I - 1, N, CostArray, NewAccMaxPathSums, AccTotalIncrements);
        true ->
            LeftSubtreeMaxPathSum = array:get(LeftChild, AccMaxPathSums),
            RightSubtreeMaxPathSum = array:get(RightChild, AccMaxPathSums),

            IncrementsAtThisLevel = abs(LeftSubtreeMaxPathSum - RightSubtreeMaxPathSum),
            NewAccTotalIncrements = AccTotalIncrements + IncrementsAtThisLevel,

            MaxOfChildrenPaths = max(LeftSubtreeMaxPathSum, RightSubtreeMaxPathSum),
            NewAccMaxPathSums = array:set(I, CurrentCost + MaxOfChildrenPaths, AccMaxPathSums),

            make_costs_equal_in_binary_tree_impl(I - 1, N, CostArray, NewAccMaxPathSums, NewAccTotalIncrements)
    end.