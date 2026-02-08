%% Definition for a Node.
%% -record(node, {val = 0 :: integer(), left = null :: 'null' | #node{}, right = null :: 'null' | #node{}, next = null :: 'null' | #node{}}).

-spec connect(Root :: #node{} | null) -> #node{} | null.
connect(Root) ->
    connect(Root, null).

connect(null, _) -> null;
connect(#node{left = Left, right = Right, next = Next}, Prev) ->
    case Prev of
        null -> connect(Left, Right, Next);
        _ -> connect(Left, Right, Prev)
    end;
connect(Left, Right, Prev) ->
    case Right of
        null -> null;
        _ -> 
            Right#node{next = Left}
            connect(Right, Prev);
