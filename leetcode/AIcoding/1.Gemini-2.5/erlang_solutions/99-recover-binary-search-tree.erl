-module(solution).
-export([recoverTree/1]).

-record(tree_node, {val, left, right}).

inorder_find_swapped(nil) ->
    ok;
inorder_find_swapped(Node) ->
    % Traverse left subtree
    inorder_find_swapped(Node#tree_node.left),

    % Process current node
    PrevVal = get(prev_node_val),
    CurrentVal = Node#tree_node.val,

    if PrevVal =/= nil andalso CurrentVal < PrevVal ->
        % This is a violation of BST property (CurrentVal should be >= PrevVal)
        % If first_node_val is not set, this is the first violation.
        % The 'prev' node is the first misplaced node.
        if get(first_node_val) == nil ->
            put(first_node_val, PrevVal)
        else
            ok
        end,
        % The 'current' node is the second misplaced node.
        % This will be updated if multiple violations occur (only the last one matters for 'second').
        put(second_node_val, CurrentVal)
    else
        ok
    end,

    % Update prev_node_val for the next comparison
    put(prev_node_val, CurrentVal),

    % Traverse right subtree
    inorder_find_swapped(Node#tree_node.right).

rebuild_tree(nil, _, _) ->
    nil;
rebuild_tree(Node, SwapVal1, SwapVal2) ->
    CurrentVal = Node#tree_node.val,
    NewVal = case CurrentVal of
                 SwapVal1 -> SwapVal2;
                 SwapVal2 -> SwapVal1;
                 _ -> CurrentVal
             end,

    NewLeft = rebuild_tree(Node#tree_node.left, SwapVal1, SwapVal2),
    NewRight = rebuild_tree(Node#tree_node.right, SwapVal1, SwapVal2),

    Node#tree_node{val = NewVal, left = NewLeft, right = NewRight}.

recoverTree(Root) ->
    % Initialize process dictionary entries for storing traversal state.
    % These act as mutable global variables for the current process.
    put(prev_node_val, nil),
    put(first_node_val, nil),
    put(second_node_val, nil),

    % Perform in-order traversal to find the two values that are swapped.
    inorder_find_swapped(Root),

    % Retrieve the identified values from the process dictionary.
    Val1 = get(first_node_val),
    Val2 = get(second_node_val),

    % Clean up process dictionary entries (optional, but good practice).
    erase(prev_node_val),
    erase(first_node_val),
    erase(second_node_val),

    % Rebuild the tree by creating new nodes with the swapped values.
    % This is the Erlang-idiomatic way to "modify" an immutable data structure.
    rebuild_tree(Root, Val1, Val2).