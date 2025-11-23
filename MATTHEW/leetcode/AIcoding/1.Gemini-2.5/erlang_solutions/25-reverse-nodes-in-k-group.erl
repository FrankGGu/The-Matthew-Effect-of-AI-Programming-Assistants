-record(list_node, {val, next}).

-spec reverse_k_group(Head :: list_node() | null, K :: integer()) -> list_node() | null.
reverse_k_group(Head, K) ->
    case get_kth_node(Head, K) of
        null ->
            Head; % Not enough nodes to reverse, return as is
        KthNode ->
            NextSegmentHead = KthNode#list_node.next,
            % Disconnect KthNode from the rest of the list
            KthNode#list_node.next = null,

            % Reverse the current segment (from Head to KthNode)
            NewHeadOfSegment = reverse_list(Head),

            % The original Head is now the tail of the reversed segment.
            % Connect its 'next' to the result of the recursive call
            % for the remaining list.
            Head#list_node.next = reverse_k_group(NextSegmentHead, K),

            NewHeadOfSegment
    end.

get_kth_node(Node, 1) ->
    Node;
get_kth_node(null, _) ->
    null;
get_kth_node(Node, K) ->
    get_kth_node(Node#list_node.next, K - 1).

reverse_list(Head) ->
    reverse_list(Head, null).

reverse_list(null, Prev) ->
    Prev;
reverse_list(Current, Prev) ->
    Next = Current#list_node.next,
    Current#list_node.next = Prev,
    reverse_list(Next, Current).