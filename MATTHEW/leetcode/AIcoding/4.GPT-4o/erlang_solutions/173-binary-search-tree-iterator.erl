%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

%% Initialize the iterator
-spec bst_iterator_init_(Root :: #tree_node{} | null) -> any().
bst_iterator_init_(Root) ->
    %% Initialize the stack with all left nodes of the tree
    bst_iterator_init_(Root, []).

-spec bst_iterator_init_(Root :: #tree_node{} | null, Stack :: [#tree_node{}]) -> [#tree_node{}].
bst_iterator_init_(null, Stack) -> Stack;
bst_iterator_init_(#tree_node{left = Left, val = Val, right = Right}, Stack) ->
    bst_iterator_init_(Left, [{Val, Right} | Stack]).

%% Return the next smallest value in the BST
-spec bst_iterator_next() -> integer().
bst_iterator_next() ->
    %% Pop the top of the stack and push its right child
    case lists:hd(Stack) of
        {Val, Right} ->
            Stack1 = case Right of
                        null -> Stack;
                        _ -> bst_iterator_init_(Right, Stack)
                      end,
            {Val, Stack1};
        _ -> {error, no_more_elements}
    end.

%% Check if there is a next element
-spec bst_iterator_has_next() -> boolean().
bst_iterator_has_next() ->
    case Stack of
        [] -> false;
        _ -> true
    end.
