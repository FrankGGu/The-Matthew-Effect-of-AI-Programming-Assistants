-module(solution).
-export([add_strings/2]).

-spec add_strings(unicode:unicode_binary(), unicode:unicode_binary()) -> unicode:unicode_binary().
add_strings(Num1, Num2) ->
    %% Reverse the strings for easier processing from least significant digit
    Num1Reversed = lists:reverse(Num1),
    Num2Reversed = lists:reverse(Num2),
    
    %% Perform the addition with carry
    {Result, _} = add_strings_recursive(Num1Reversed, Num2Reversed, 0, []),
    
    %% Reverse the result to get the correct order
    lists:reverse(Result).

%% Recursive helper function to add two strings
-spec add_strings_recursive([integer()], [integer()], integer(), [integer()]) -> {[integer()], integer()}.
add_strings_recursive([], [], 0, Acc) -> {Acc, 0};
add_strings_recursive([H1 | T1], [], Carry, Acc) ->
    Sum = H1 + Carry,
    NewCarry = Sum div 10,
    add_strings_recursive(T1, [], NewCarry, [Sum rem 10 | Acc]);
add_strings_recursive([], [H2 | T2], Carry, Acc) ->
    Sum = H2 + Carry,
    NewCarry = Sum div 10,
    add_strings_recursive([], T2, NewCarry, [Sum rem 10 | Acc]);
add_strings_recursive([H1 | T1], [H2 | T2], Carry, Acc) ->
    Sum = H1 + H2 + Carry,
    NewCarry = Sum div 10,
    add_strings_recursive(T1, T2, NewCarry, [Sum rem 10 | Acc]).
