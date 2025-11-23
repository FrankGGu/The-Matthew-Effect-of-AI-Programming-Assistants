-spec next_larger_nodes(Head :: #list_node{} | null) -> [integer()].
next_larger_nodes(null) -> [];
next_larger_nodes(Head) ->
    List = list_to_array(Head, []),
    Stack = [],
    Result = lists:duplicate(length(List), 0),
    process_nodes(List, Stack, Result, 0).

list_to_array(null, Acc) -> lists:reverse(Acc);
list_to_array(#list_node{val = Val, next = Next}, Acc) ->
    list_to_array(Next, [Val | Acc]).

process_nodes([], _Stack, Result, _Index) -> Result;
process_nodes([Val | Rest], Stack, Result, Index) ->
    NewStack = pop_stack(Stack, Val, Result),
    process_nodes(Rest, [{Val, Index} | NewStack], Result, Index + 1).

pop_stack([], _Val, Result) -> [];
pop_stack([{StackVal, StackIndex} | Rest], Val, Result) when StackVal < Val ->
    NewResult = setelement(StackIndex + 1, Result, Val),
    pop_stack(Rest, Val, NewResult);
pop_stack(Stack, _Val, _Result) -> Stack.