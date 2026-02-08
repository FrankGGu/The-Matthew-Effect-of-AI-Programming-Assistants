-spec partition(Head :: #list_node{} | null, X :: integer()) -> #list_node{} | null.
partition(Head, X) ->
    {Small, Large} = split(Head, X),
    connect(Small, Large).

split(Head, X) ->
    split(Head, X, #list_node{}, #list_node{}).

split(null, _X, Small, Large) ->
    {Small, Large};
split(#list_node{val = Val, next = Next}, X, Small, Large) when Val < X ->
    NewSmall = #list_node{val = Val, next = null},
    SmallNext = append(Small, NewSmall),
    split(Next, X, SmallNext, Large);
split(#list_node{val = Val, next = Next}, X, Small, Large) ->
    NewLarge = #list_node{val = Val, next = null},
    LargeNext = append(Large, NewLarge),
    split(Next, X, Small, LargeNext).

append(null, Node) ->
    Node;
append(#list_node{next = null} = Head, Node) ->
    Head#list_node{next = Node};
append(#list_node{next = Next} = Head, Node) ->
    Head#list_node{next = append(Next, Node)}.

connect(null, Large) ->
    Large;
connect(Small, null) ->
    Small;
connect(#list_node{next = null} = Small, Large) ->
    Small#list_node{next = Large};
connect(#list_node{next = Next} = Small, Large) ->
    Small#list_node{next = connect(Next, Large)}.