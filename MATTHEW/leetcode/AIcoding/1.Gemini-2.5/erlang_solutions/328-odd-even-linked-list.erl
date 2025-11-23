-record(list_node, {val = 0, next = null}).

odd_even_list(null) -> null;
odd_even_list(#list_node{next = null} = Head) -> Head;
odd_even_list(Head) ->
    EvenHead = Head#list_node.next,
    odd_even_list_loop(Head, EvenHead, EvenHead),
    Head.

odd_even_list_loop(OddCurr, EvenCurr, EvenHead) ->
    if
        EvenCurr == null; EvenCurr#list_node.next == null ->
            OddCurr#list_node.next = EvenHead;
        true ->
            NextOdd = EvenCurr#list_node.next,
            NextEven = NextOdd#list_node.next,

            OddCurr#list_node.next = NextOdd,
            EvenCurr#list_node.next = NextEven,

            odd_even_list_loop(NextOdd, NextEven, EvenHead)
    end.