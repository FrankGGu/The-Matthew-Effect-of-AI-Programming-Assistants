-record(node, {val = 0 :: integer(),
               prev = null :: 'null' | #node{},
               next = null :: 'null' | #node{},
               child = null :: 'null' | #node{}}).

-spec flatten(Head :: #node{} | null) -> #node{} | null.
flatten(Head) ->
    case Head of
        null -> null;
        _ -> 
            {NewHead, _} = flatten_helper(Head),
            NewHead
    end.

flatten_helper(Node) ->
    case Node of
        null -> {null, null};
        #node{next = null, child = null} -> {Node, Node};
        #node{next = Next, child = null} ->
            {Head, Tail} = flatten_helper(Next),
            Node#node{next = Head, prev = null},
            Head#node{prev = Node},
            {Node, Tail};
        #node{next = Next, child = Child} ->
            {ChildHead, ChildTail} = flatten_helper(Child),
            Node#node{next = ChildHead, child = null},
            ChildHead#node{prev = Node},
            case Next of
                null -> {Node, ChildTail};
                _ ->
                    {NextHead, NextTail} = flatten_helper(Next),
                    ChildTail#node{next = NextHead},
                    NextHead#node{prev = ChildTail},
                    {Node, NextTail}
            end
    end.