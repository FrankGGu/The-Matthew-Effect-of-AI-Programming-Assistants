%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec delete_node(#tree_node{} | null, integer()) -> #tree_node{} | null.
delete_node(null, _) -> null;
delete_node(#tree_node{val = Key, left = Left, right = Right} = Node, Key) ->
    case {Left, Right} of
        {null, null} -> null;  %% Node has no children
        {null, _} -> Right;     %% Node has only right child
        {_, null} -> Left;      %% Node has only left child
        {_, _} -> 
            %% Node has two children, find the inorder successor (smallest in right subtree)
            MinNode = find_min(Right),
            %% Replace current node value with inorder successor value
            Node#tree_node{val = MinNode#tree_node.val, right = delete_node(Right, MinNode#tree_node.val)}
    end;
delete_node(#tree_node{val = Key, left = Left, right = Right}, Key) when Key < Key ->
    % Search in the left subtree
    Node#tree_node{left = delete_node(Left, Key)};
delete_node(#tree_node{val = Key, left = Left, right = Right}, Key) when Key > Key ->
    % Search in the right subtree
    Node#tree_node{right = delete_node(Right, Key)}.

%% Helper function to find the minimum node (leftmost node) in the right subtree.
-spec find_min(#tree_node{}) -> #tree_node{}.
find_min(#tree_node{left = null} = Node) -> Node;
find_min(#tree_node{left = Left}) -> find_min(Left).
