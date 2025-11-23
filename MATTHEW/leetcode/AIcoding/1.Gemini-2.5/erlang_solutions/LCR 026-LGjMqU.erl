-record('ListNode', {val, next}).

-export([reorderList/1]).

reorderList(null) -> null;
reorderList(Head) ->
    case Head#ListNode.next of
        null -> Head;
        _ ->
            case Head#ListNode.next#ListNode.next of
                null -> Head;
                _ ->
                    {FirstHalfHead, SecondHalfHead} = split_list_erlang(Head),
                    ReversedSecondHalf = reverse_list(SecondHalfHead),
                    merge_lists(FirstHalfHead, ReversedSecondHalf),
                    Head
            end
    end.

split_list_erlang(Head) ->
    split_list_erlang_loop(Head, Head, null, Head).

split_list_erlang_loop(Slow, Fast, PrevSlow, FirstHalfHead) ->
    case Fast of
        null ->
            PrevSlow#ListNode{next = null},
            {FirstHalfHead, Slow};
        _ ->
            case Fast#ListNode.next of
                null ->
                    PrevSlow#ListNode{next = null},
                    {FirstHalfHead, Slow};
                _ ->
                    split_list_erlang_loop(Slow#ListNode.next, Fast#ListNode.next#ListNode.next, Slow, FirstHalfHead)
            end
    end.

reverse_list(null) -> null;
reverse_list(Head) -> reverse_list_loop(Head, null).

reverse_list_loop(null, Acc) -> Acc;
reverse_list_loop(Node, Acc) ->
    Next = Node#ListNode.next,
    Node#ListNode{next = Acc},
    reverse_list_loop(Next, Node).

merge_lists(L1, null) -> L1;
merge_lists(null, L2) -> L2;
merge_lists(L1, L2) ->
    L1Next = L1#ListNode.next,
    L2Next = L2#ListNode.next,
    L1#ListNode{next = L2},
    L2#ListNode{next = merge_lists(L1Next, L2Next)},
    L1.