-spec odd_even_list(Head :: #list_node{} | null) -> #list_node{} | null.
odd_even_list(null) -> null;
odd_even_list(Head) ->
    case Head#list_node.next of
        null -> Head;
        _ ->
            Odd = Head,
            Even = Head#list_node.next,
            EvenHead = Even,
            loop(Odd, Even),
            Odd#list_node.next = EvenHead,
            Head
    end.

loop(Odd, Even) ->
    case Even#list_node.next of
        null -> 
            Odd#list_node.next = Even#list_node.next,
            ok;
        NextOdd ->
            Odd#list_node.next = NextOdd,
            NextEven = NextOdd#list_node.next,
            case NextEven of
                null -> 
                    Odd#list_node.next = NextOdd,
                    ok;
                _ ->
                    Even#list_node.next = NextEven,
                    loop(NextOdd, NextEven)
            end
    end.