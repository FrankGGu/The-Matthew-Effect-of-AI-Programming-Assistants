-spec remove_nodes(Head :: #list_node{} | null) -> #list_node{} | null.
remove_nodes(Head) ->
    Stack = [],
    Current = Head,
    Stack1 = build_stack(Current, Stack),
    case Stack1 of
        [] -> null;
        _ ->
            NewHead = hd(Stack1),
            connect_nodes(Stack1),
            NewHead
    end.

build_stack(null, Stack) -> Stack;
build_stack(#list_node{val = Val, next = Next}, Stack) ->
    NewStack = drop_less(Val, Stack),
    build_stack(Next, [#list_node{val = Val} | NewStack]).

drop_less(_, []) -> [];
drop_less(Val, [#list_node{val = V} | Rest]) when V < Val ->
    drop_less(Val, Rest);
drop_less(_, Stack) -> Stack.

connect_nodes([]) -> ok;
connect_nodes([_]) -> ok;
connect_nodes([Node1, Node2 | Rest]) ->
    Node1#list_node{next = Node2},
    connect_nodes([Node2 | Rest]).