-module(add_two_numbers_ii).
-export([add_two_numbers/2]).

add_two_numbers(Num1, Num2) ->
    List1 = to_list(Num1),
    List2 = to_list(Num2),
    Sum = add(List1, List2),
    to_linked_list(Sum).

to_list(nil) ->
    [];
to_list({node, Val, Next}) ->
    [Val | to_list(Next)].

to_linked_list([]) ->
    nil;
to_linked_list([H | T]) ->
    {node, H, to_linked_list(T)}.

add([], [], 0) ->
    [];
add([], [], Carry) ->
    [Carry];
add([A | As], [], Carry) ->
    Sum = A + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    [Digit | add(As, [], NewCarry)];
add([], [B | Bs], Carry) ->
    Sum = B + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    [Digit | add([], Bs, NewCarry)];
add([A | As], [B | Bs], Carry) ->
    Sum = A + B + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    [Digit | add(As, Bs, NewCarry)].