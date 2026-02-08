%% Definition for Node.
%% -record(node, {val = 0 :: integer(), left = null, right = null, next = null}).

-spec connect(Root :: #node{} | null) -> #node{} | null.
connect(null) -> null;
connect(Root) ->
    connect_level(Root),
    Root.

-spec connect_level(Node :: #node{}) -> ok.
connect_level(null) -> ok;
connect_level(#node{left = Left, right = Right, next = Next}) ->
    case Next of
        null -> 
            % If no next, the right child's next is null
            connect_level(Left),
            connect_level(Right);
        _ -> 
            % Connect the next right pointers
            Right#node{next = Next#node.left},
            connect_level(Left),
            connect_level(Right)
    end.
