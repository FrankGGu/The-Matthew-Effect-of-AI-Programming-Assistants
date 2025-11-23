-spec reverse_k_group(Head :: #list_node{} | null, K :: integer()) -> #list_node{} | null.
reverse_k_group(Head, K) ->
    case has_k_nodes(Head, K) of
        true ->
            {Reversed, Next} = reverse(Head, K),
            Head#list_node{next = reverse_k_group(Next, K), val = Reversed#list_node.val};
        false ->
            Head
    end.

-spec has_k_nodes(Head :: #list_node{} | null, K :: integer()) -> boolean().
has_k_nodes(Head, K) ->
    has_k_nodes(Head, K, 0).

-spec has_k_nodes(Head :: #list_node{} | null, K :: integer(), Count :: integer()) -> boolean().
has_k_nodes(_Head, K, Count) when Count >= K ->
    true;
has_k_nodes(null, _K, _Count) ->
    false;
has_k_nodes(Head, K, Count) ->
    has_k_nodes(Head#list_node.next, K, Count + 1).

-spec reverse(Head :: #list_node{} | null, K :: integer()) -> {Reversed :: #list_node{} | null, Next :: #list_node{} | null}.
reverse(Head, K) ->
    reverse(Head, K, null).

-spec reverse(Head :: #list_node{} | null, K :: integer(), Acc :: #list_node{} | null) -> {Reversed :: #list_node{} | null, Next :: #list_node{} | null}.
reverse(Head, 0, Acc) ->
    {Acc, Head};
reverse(null, _K, Acc) ->
    {Acc, null};
reverse(Head, K, Acc) ->
    Next = Head#list_node.next,
    reverse(Next, K - 1, Head#list_node{next = Acc}).