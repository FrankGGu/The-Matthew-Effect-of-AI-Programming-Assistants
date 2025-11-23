-spec double_it(Head :: #list_node{} | null) -> #list_node{} | null.
double_it(Head) ->
    case reverse(Head) of
        null -> null;
        Reversed ->
            NewHead = double_reversed(Reversed, 0),
            reverse(NewHead)
    end.

reverse(Head) ->
    reverse(Head, null).

reverse(Node, Prev) ->
    case Node of
        null -> Prev;
        #list_node{val = Val, next = Next} ->
            reverse(Next, #list_node{val = Val, next = Prev})
    end.

double_reversed(Node, Carry) ->
    case Node of
        null when Carry > 0 -> #list_node{val = Carry, next = null};
        null -> null;
        #list_node{val = Val, next = Next} ->
            NewVal = Val * 2 + Carry,
            Digit = NewVal rem 10,
            NewCarry = NewVal div 10,
            #list_node{val = Digit, next = double_reversed(Next, NewCarry)}
    end.