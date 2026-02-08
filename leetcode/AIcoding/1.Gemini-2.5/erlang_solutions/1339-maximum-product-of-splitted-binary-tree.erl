-module(solution).
-export([max_product/1]).

-record(tree_node, {val, left, right}).

collect_sums(nil, AccSums) ->
    {0, AccSums};
collect_sums(#tree_node{val = Val, left = Left, right = Right}, AccSums) ->
    {LeftSum, AccSums1} = collect_sums(Left, AccSums),
    {RightSum, AccSums2} = collect_sums(Right, AccSums1),
    CurrentSubtreeSum = Val + LeftSum + RightSum,
    {CurrentSubtreeSum, [CurrentSubtreeSum | AccSums2]}.

max_product(Root) ->
    {TotalSum, AllSubtreeSums} = collect_sums(Root, []),
    MaxProduct = lists:foldl(
        fun(SubtreeSum, CurrentMax) ->
            Product = SubtreeSum * (TotalSum - SubtreeSum),
            erlang:max(Product, CurrentMax)
        end,
        0,
        AllSubtreeSums
    ),
    MaxProduct rem (1000000000 + 7).