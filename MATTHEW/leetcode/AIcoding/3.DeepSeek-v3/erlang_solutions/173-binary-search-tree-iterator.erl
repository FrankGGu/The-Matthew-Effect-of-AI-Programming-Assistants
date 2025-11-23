-record(treeNode, {val = 0 :: integer(),
                  left = null  :: 'null' | #treeNode{},
                  right = null :: 'null' | #treeNode{}}).

-spec init_(Root :: #treeNode{} | null) -> any().
init_(null) ->
    {[], []};
init_(Root) ->
    {[], [Root]}.

-spec next() -> integer().
next() ->
    case get(stack) of
        {[], []} -> 
            -1;
        {[], [H|T]} ->
            put(stack, {lists:reverse(flatten_left(H)), T}),
            next();
        {[H|T], R} ->
            put(stack, {T, R}),
            H#treeNode.val
    end.

-spec has_next() -> boolean().
has_next() ->
    case get(stack) of
        {[], []} -> false;
        _ -> true
    end.

flatten_left(null) ->
    [];
flatten_left(Node) ->
    [Node | flatten_left(Node#treeNode.left)].