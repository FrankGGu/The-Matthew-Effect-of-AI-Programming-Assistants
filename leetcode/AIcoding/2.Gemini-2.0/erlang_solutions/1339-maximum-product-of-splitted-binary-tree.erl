-module(max_product_splitted_binary_tree).
-export([max_product/1]).

max_product(Root) ->
    {_, TotalSum} = tree_sum(Root),
    {MaxProduct, _} = max_product_helper(Root, TotalSum),
    MaxProduct.

tree_sum(null) ->
    {0, 0};
tree_sum({Val, Left, Right}) ->
    {LeftSum, LeftTotal} = tree_sum(Left),
    {RightSum, RightTotal} = tree_sum(Right),
    Sum = Val + LeftTotal + RightTotal,
    {Sum, Sum}.

max_product_helper(null, _) ->
    {0, 0};
max_product_helper({Val, Left, Right}, TotalSum) ->
    {LeftProduct, LeftSum} = max_product_helper(Left, TotalSum),
    {RightProduct, RightSum} = max_product_helper(Right, TotalSum),
    LeftProd = LeftSum * (TotalSum - LeftSum),
    RightProd = RightSum * (TotalSum - RightSum),
    CurrentProduct = max([LeftProduct, RightProduct, LeftProd, RightProd]),
    Sum = Val + LeftSum + RightSum,
    {CurrentProduct, Sum}.

max([A, B, C, D]) ->
  max(max(A, B), max(C, D)).

max(A, B) ->
  if A > B -> A;
     true -> B
  end.