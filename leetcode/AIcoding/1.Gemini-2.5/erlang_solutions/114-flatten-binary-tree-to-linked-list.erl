-module(solution).
-export([flatten/1]).

flatten(Root) ->
    flatten_helper(Root, nil).

flatten_helper(nil, Prev) ->
    Prev;
flatten_helper({Val, Left, Right}, Prev) ->
    %% 1. Recursively flatten the right subtree.
    %%    The result `FlattenedRightHead` will be the head of the flattened list
    %%    starting from the original `Right` child, and it will be linked to `Prev`.
    FlattenedRightHead = flatten_helper(Right, Prev),

    %% 2. Recursively flatten the left subtree.
    %%    The result `FlattenedLeftHead` will be the head of the flattened list
    %%    starting from the original `Left` child, and it will be linked to `FlattenedRightHead`.
    FlattenedLeftHead = flatten_helper(Left, FlattenedRightHead),

    %% 3. Create the current node for the flattened list.
    %%    Its left child must be `nil`.
    %%    Its right child must point to the head of the flattened left subtree
    %%    (which now includes the original right subtree).
    {Val, nil, FlattenedLeftHead}.