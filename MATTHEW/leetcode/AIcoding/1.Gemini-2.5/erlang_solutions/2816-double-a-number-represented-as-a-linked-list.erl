-record(list_node, {val :: integer(), next :: list_node() | nil}).

doubleIt(Head) ->
    {FinalCarry, NewHead} = double_and_carry(Head),
    if FinalCarry > 0 ->
        #list_node{val=FinalCarry, next=NewHead};
    true ->
        NewHead
    end.

double_and_carry(nil) -> {0, nil};
double_and_carry(#list_node{val=Val, next=Next}) ->
    {NextCarry, NewNextNode} = double_and_carry(Next),
    NewVal = Val * 2 + NextCarry,
    Digit = NewVal rem 10,
    CurrentCarry = NewVal div 10,
    NewNode = #list_node{val=Digit, next=NewNextNode},
    {CurrentCarry, NewNode}.