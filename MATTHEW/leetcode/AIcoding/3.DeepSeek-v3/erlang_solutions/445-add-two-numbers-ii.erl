-spec add_two_numbers(L1 :: #list_node{} | null, L2 :: #list_node{} | null) -> #list_node{} | null.
add_two_numbers(L1, L2) ->
    Stack1 = list_to_stack(L1, []),
    Stack2 = list_to_stack(L2, []),
    {ResultStack, Carry} = add_stacks(Stack1, Stack2, [], 0),
    FinalStack = case Carry of
        0 -> ResultStack;
        _ -> [Carry | ResultStack]
    end,
    stack_to_list(FinalStack, null).

list_to_stack(null, Stack) -> Stack;
list_to_stack(Node, Stack) ->
    list_to_stack(Node#list_node.next, [Node#list_node.val | Stack]).

add_stacks([], [], ResultStack, Carry) -> {ResultStack, Carry};
add_stacks(Stack1, Stack2, ResultStack, Carry) ->
    Val1 = case Stack1 of [] -> 0; [H1 | _] -> H1 end,
    Val2 = case Stack2 of [] -> 0; [H2 | _] -> H2 end,
    Sum = Val1 + Val2 + Carry,
    NewVal = Sum rem 10,
    NewCarry = Sum div 10,
    NewStack1 = case Stack1 of [] -> []; [_ | T1] -> T1 end,
    NewStack2 = case Stack2 of [] -> []; [_ | T2] -> T2 end,
    add_stacks(NewStack1, NewStack2, [NewVal | ResultStack], NewCarry).

stack_to_list([], Head) -> Head;
stack_to_list([Val | Rest], Head) ->
    NewNode = #list_node{val = Val, next = Head},
    stack_to_list(Rest, NewNode).