%% Definition for singly-linked list.
-record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec add_two_numbers(#list_node{} | null, #list_node{} | null) -> #list_node{} | null.
add_two_numbers(L1, L2) ->
    Stack1 = to_stack(L1, []),
    Stack2 = to_stack(L2, []),
    SumStack = add_stacks(Stack1, Stack2, 0, []),
    build_list_from_stack(SumStack).

%% Convert linked list to stack (list of integers) with most significant digit at head
-spec to_stack(#list_node{} | null, [integer()]) -> [integer()].
to_stack(null, Acc) -> Acc;
to_stack(#list_node{val=V, next=Next}, Acc) ->
    to_stack(Next, [V|Acc]).

%% Add two stacks with carry, result in a stack
-spec add_stacks([integer()], [integer()], integer(), [integer()]) -> [integer()].
add_stacks([], [], 0, Acc) -> Acc;
add_stacks([], [], Carry, Acc) when Carry > 0 ->
    [Carry|Acc];
add_stacks(S1, S2, Carry, Acc) ->
    {V1, Rest1} = pop_head(S1),
    {V2, Rest2} = pop_head(S2),
    Sum = V1 + V2 + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    add_stacks(Rest1, Rest2, NewCarry, [Digit|Acc]).

-spec pop_head([integer()]) -> {integer(), [integer()]}.
pop_head([]) -> {0, []};
pop_head([H|T]) -> {H, T}.

%% Build linked list from stack
-spec build_list_from_stack([integer()]) -> #list_node{} | null.
build_list_from_stack([]) -> null;
build_list_from_stack([H|T]) ->
    #list_node{val=H, next=build_list_from_stack(T)}.
