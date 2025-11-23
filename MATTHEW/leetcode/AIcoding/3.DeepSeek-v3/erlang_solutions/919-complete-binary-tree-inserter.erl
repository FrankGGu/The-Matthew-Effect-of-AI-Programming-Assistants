-record(treeNode, {val = 0 :: integer(),
                   left = null  :: 'null' | #treeNode{},
                   right = null :: 'null' | #treeNode{}}).

-spec new_(Root :: #treeNode{} | null) -> any().
new_(null) ->
    {queue:new(), null};
new_(Root) ->
    Q = queue:new(),
    Q1 = queue:in(Root, Q),
    {Q1, Root}.

-spec insert(State :: any(), Val :: integer()) -> integer().
insert({Q, Root}, Val) ->
    NewNode = #treeNode{val=Val},
    case Root of
        null ->
            {queue:from_list([NewNode]), NewNode};
        _ ->
            insert_helper(Q, NewNode)
    end.

insert_helper(Q, NewNode) ->
    {Front, Q1} = queue:out(Q),
    case Front of
        {value, Node} ->
            case Node#treeNode.left of
                null ->
                    Q2 = queue:in(NewNode, Q1),
                    {queue:in(Node#treeNode{left=NewNode}, Q2), Node#treeNode.val};
                _ ->
                    case Node#treeNode.right of
                        null ->
                            Q2 = queue:in(NewNode, Q1),
                            {queue:in(Node#treeNode{right=NewNode}, Q2), Node#treeNode.val};
                        _ ->
                            Q2 = queue:in(Node#treeNode.left, Q1),
                            Q3 = queue:in(Node#treeNode.right, Q2),
                            insert_helper(Q3, NewNode)
                    end
            end
    end.

-spec get_root(State :: any()) -> #treeNode{} | null.
get_root({_, Root}) ->
    Root.