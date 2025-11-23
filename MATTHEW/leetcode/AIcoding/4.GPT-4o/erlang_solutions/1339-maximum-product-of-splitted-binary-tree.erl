-module(solution).
-export([max_product/1]).

-record(node, {val, left = none, right = none}).

max_product(Root) ->
    {Total, _} = sum_tree(Root),
    MaxProduct = max_product_helper(Root, Total),
    MaxProduct rem (10^9 + 7).

sum_tree(none) -> {0, 0};
sum_tree(#node{val=Val, left=Left, right=Right}) ->
    {Total, Subsum} = sum_tree(Left),
    {Total1, Subsum1} = sum_tree(Right),
    {Val + Total + Total1, Val + Total + Total1}.

max_product_helper(none, _) -> 0;
max_product_helper(#node{val=Val, left=Left, right=Right}, Total) ->
    LeftSum = case Left of
        none -> 0;
        _ -> sum_tree(Left)
    end,
    RightSum = case Right of
        none -> 0;
        _ -> sum_tree(Right)
    end,
    MaxProduct = max(LeftSum * (Total - LeftSum), RightSum * (Total - RightSum)),
    max(MaxProduct, max_product_helper(Left, Total)),
    max(MaxProduct, max_product_helper(Right, Total)).