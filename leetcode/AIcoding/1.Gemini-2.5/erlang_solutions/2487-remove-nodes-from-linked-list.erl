-record(list_node, {val :: integer(), next :: list_node() | nil}).

remove_nodes(nil) ->
    nil;
remove_nodes(#list_node{val = Val, next = Next}) ->
    NewNext = remove_nodes(Next),
    case NewNext of
        nil ->
            #list_node{val = Val, next = nil};
        #list_node{val = NextVal} when Val >= NextVal ->
            #list_node{val = Val, next = NewNext};
        #list_node{val = NextVal} when Val < NextVal ->
            NewNext
    end.