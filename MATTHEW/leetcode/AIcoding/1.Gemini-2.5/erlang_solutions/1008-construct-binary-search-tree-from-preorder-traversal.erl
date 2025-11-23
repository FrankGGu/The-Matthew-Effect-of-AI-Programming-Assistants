-module(solution).
-export([bst_from_preorder/1]).

bst_from_preorder(Preorder) ->
    %% Call a helper function that takes the preorder list and the current allowed range
    %% for node values (LowerBound, UpperBound).
    %% The initial range is from a value less than any possible node value (e.g., -1)
    %% to a value greater than any possible node value (e.g., 'infinity').
    %% The helper function returns a tuple {Node, RemainingPreorderList}.
    {Root, _RemainingPreorder} = build_tree(Preorder, -1, infinity),
    Root.

build_tree([], _Lower, _Upper) ->
    %% If the preorder list is empty, there are no more nodes to build.
    {null, []};
build_tree([H | T], Lower, Upper) ->
    %% H is the current head of the preorder list.
    %% If H is outside the valid range (Lower, Upper) for the current subtree,
    %% it means H belongs to a parent's right subtree (if H > Upper) or
    %% it's an invalid element (if H < Lower, which shouldn't happen in a valid preorder).
    %% In this case, we return 'null' for the current subtree and don't consume H.
    if
        H < Lower orelse H > Upper ->
            {null, [H | T]};
        true ->
            %% H is within the valid range, so it becomes the root of the current subtree.
            %% Recursively build the left child. Its values must be greater than Lower
            %% and less than H. The list passed is T (the rest of the preorder list).
            {LeftChild, RemainingAfterLeft} = build_tree(T, Lower, H),

            %% Recursively build the right child. Its values must be greater than H
            %% and less than Upper. The list passed is RemainingAfterLeft, as the
            %% left subtree might have consumed some elements.
            {RightChild, RemainingAfterRight} = build_tree(RemainingAfterLeft, H, Upper),

            %% Return the constructed node and the list remaining after building both children.
            {{H, LeftChild, RightChild}, RemainingAfterRight}
    end.