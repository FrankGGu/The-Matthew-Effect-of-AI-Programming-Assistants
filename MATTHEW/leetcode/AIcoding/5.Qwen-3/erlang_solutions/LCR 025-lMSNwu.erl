-module(leetcode_445).
-export([add_two_numbers/2]).

add_two_numbers(Num1, Num2) ->
    List1 = to_list(Num1),
    List2 = to_list(Num2),
    Result = add(List1, List2, 0),
    to_linked_list(Result).

to_list(nil) -> [];
to_list({node, Val, Next}) ->
    [Val | to_list(Next)].

to_linked_list([]) -> nil;
to_linked_list([H | T]) ->
    {node, H, to_linked_list(T)}.

add([], [], Carry) ->
    if Carry == 0 -> [];
       true -> [Carry]
    end;
add([H1 | T1], [H2 | T2], Carry) ->
    Sum = H1 + H2 + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    [Digit | add(T1, T2, NewCarry)].