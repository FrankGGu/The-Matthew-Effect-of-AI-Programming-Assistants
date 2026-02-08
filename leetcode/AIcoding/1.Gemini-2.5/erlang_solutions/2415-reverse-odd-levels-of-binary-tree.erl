-module(solution).
-export([reverse_odd_levels/1]).

-record(treenode, {val=0, left=null, right=null}).

reverse_odd_levels(Root) ->
    if Root == null ->
        null;
    true ->
        % Level 0 is the root. Its children are at Level 1.
        % We start the symmetric swap from Level 1.
        % The root's value (at Level 0) is never reversed.
        {NewLeftChild, NewRightChild} = dfs_swap(Root#treenode.left, Root#treenode.right, 1),
        Root#treenode{left = NewLeftChild, right = NewRightChild}
    end.

dfs_swap(Node1, Node2, Level) ->
    case {Node1, Node2} of
        {null, null} ->
            {null, null};
        {NodeA, null} ->
            % NodeA exists, NodeB is null. No symmetric partner for NodeA.
            % Deep copy NodeA and its subtree without any value swaps.
            {deep_copy_subtree(NodeA), null};
        {null, NodeB} ->
            % NodeB exists, NodeA is null. No symmetric partner for NodeB.
            % Deep copy NodeB and its subtree without any value swaps.
            {null, deep_copy_subtree(NodeB)};
        {NodeA, NodeB} ->
            % Both nodes exist, perform symmetric processing.
            ValA = NodeA#treenode.val,
            ValB = NodeB#treenode.val,

            % Recursively process children symmetrically.
            % NodeA's left child is symmetric to NodeB's right child.
            % NodeA's right child is symmetric to NodeB's left child.
            {NewLeftA_Child, NewRightB_Child} = dfs_swap(NodeA#treenode.left, NodeB#treenode.right, Level + 1),
            {NewRightA_Child, NewLeftB_Child} = dfs_swap(NodeA#treenode.right, NodeB#treenode.left, Level + 1),

            if (Level rem 2 == 1) -> % Odd level, swap values
                NewNodeA = NodeA#treenode{val = ValB, left = NewLeftA_Child, right = NewRightA_Child},
                NewNodeB = NodeB#treenode{val = ValA, left = NewLeftB_Child, right = NewRightB_Child},
                {NewNodeA, NewNodeB};
            true -> % Even level, keep values
                NewNodeA = NodeA#treenode{val = ValA, left = NewLeftA_Child, right = NewRightA_Child},
                NewNodeB = NodeB#treenode{val = ValB, left = NewLeftB_Child, right = NewRightB_Child},
                {NewNodeA, NewNodeB}
            end
    end.

deep_copy_subtree(null) ->
    null;
deep_copy_subtree(Node) ->
    NewLeft = deep_copy_subtree(Node#treenode.left),
    NewRight = deep_copy_subtree(Node#treenode.right),
    Node#treenode{left = NewLeft, right = NewRight}.