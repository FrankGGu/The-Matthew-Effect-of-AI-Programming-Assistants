-spec add_two_numbers(L1 :: #list_node{} | null, L2 :: #list_node{} | null) -> #list_node{} | null.
add_two_numbers(L1, L2) ->
    S1 = list_to_stack(L1, []),
    S2 = list_to_stack(L2, []),
    {Carry, Stack} = add_stacks(S1, S2, 0, []),
    Result = if 
                 Carry > 0 -> [Carry | Stack];
                 true -> Stack
             end,
    stack_to_list(Result, null).

list_to_stack(null, Stack) -> Stack;
list_to_stack(#list_node{val = Val, next = Next}, Stack) ->
    list_to_stack(Next, [Val | Stack]).

add_stacks([], [], Carry, Stack) -> {Carry, Stack};
add_stacks([], [H2 | T2], Carry, Stack) ->
    Sum = H2 + Carry,
    NewVal = Sum rem 10,
    NewCarry = Sum div 10,
    add_stacks([], T2, NewCarry, [NewVal | Stack]);
add_stacks([H1 | T1], [], Carry, Stack) ->
    Sum = H1 + Carry,
    NewVal = Sum rem 10,
    NewCarry = Sum div 10,
    add_stacks(T1, [], NewCarry, [NewVal | Stack]);
add_stacks([H1 | T1], [H2 | T2], Carry, Stack) ->
    Sum = H1 + H2 + Carry,
    NewVal = Sum rem 10,
    NewCarry = Sum div 10,
    add_stacks(T1, T2, NewCarry, [NewVal | Stack]).

stack_to_list([], Head) -> Head;
stack_to_list([H | T], Head) ->
    Node = #list_node{val = H, next = Head},
    stack_to_list(T, Node).