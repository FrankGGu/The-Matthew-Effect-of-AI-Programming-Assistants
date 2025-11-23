-module(solution).
-export([addTwoNumbers/2]).

-record(list_node, {val :: integer(), next :: 'null' | #list_node{}}).

addTwoNumbers(L1, L2) ->
    Stack1 = list_to_stack(L1, []),
    Stack2 = list_to_stack(L2, []),
    add_stacks(Stack1, Stack2, 0, null).

list_to_stack(null, Stack) ->
    Stack;
list_to_stack(#list_node{val = V, next = N}, Stack) ->
    list_to_stack(N, [V | Stack]).

add_stacks(Stack1, Stack2, Carry, ResultList) ->
    case {Stack1, Stack2, Carry} of
        {[], [], 0} ->
            ResultList;
        _ ->
            {Digit1, NewStack1} = pop_stack(Stack1),
            {Digit2, NewStack2} = pop_stack(Stack2),
            Sum = Digit1 + Digit2 + Carry,
            NewDigit = Sum rem 10,
            NewCarry = Sum div 10,
            NewNode = #list_node{val = NewDigit, next = ResultList},
            add_stacks(NewStack1, NewStack2, NewCarry, NewNode)
    end.

pop_stack([]) ->
    {0, []};
pop_stack([H | T]) ->
    {H, T}.