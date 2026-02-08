-spec init_(Head :: #list_node{} | null) -> any().
init_(null) ->
    {null, 0};
init_(Head) ->
    {Head, length(Head)}.

length(null) ->
    0;
length(#list_node{next = Next}) ->
    1 + length(Next).

-spec get_random() -> integer().
get_random() ->
    {Head, Len} = get(),
    Index = rand:uniform(Len) - 1,
    get_nth(Head, Index).

get_nth(Head, 0) ->
    Head#list_node.val;
get_nth(#list_node{next = Next}, N) ->
    get_nth(Next, N - 1).