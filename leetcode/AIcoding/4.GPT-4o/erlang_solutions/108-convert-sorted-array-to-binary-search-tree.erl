%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec sorted_array_to_bst(Nums :: [integer()]) -> #tree_node{} | null.
sorted_array_to_bst(Nums) when length(Nums) == 0 -> null;
sorted_array_to_bst(Nums) ->
    Mid = length(Nums) div 2,
    Left = lists:sublist(Nums, 1, Mid),
    Right = lists:sublist(Nums, Mid + 1, length(Nums) - Mid - 1),
    #tree_node{
        val = lists:nth(Mid + 1, Nums),
        left = sorted_array_to_bst(Left),
        right = sorted_array_to_bst(Right)
    }.
