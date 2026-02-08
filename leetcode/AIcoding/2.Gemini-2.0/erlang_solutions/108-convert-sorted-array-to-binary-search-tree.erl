-module(sorted_array_to_bst).
-export([sorted_array_to_bst/1]).

sorted_array_to_bst(Nums) ->
    sorted_array_to_bst(Nums, 0, length(Nums) - 1).

sorted_array_to_bst(Nums, Left, Right) when Left > Right ->
    [];
sorted_array_to_bst(Nums, Left, Right) ->
    Mid = Left + (Right - Left) div 2,
    Value = lists:nth(Mid + 1, Nums),
    LeftTree = sorted_array_to_bst(Nums, Left, Mid - 1),
    RightTree = sorted_array_to_bst(Nums, Mid + 1, Right),
    [{Value, LeftTree, RightTree}].