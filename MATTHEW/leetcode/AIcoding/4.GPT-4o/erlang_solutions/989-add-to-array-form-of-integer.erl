-module(solution).
-export([add_to_array_form/2]).

add_to_array_form(A, K) ->
    K_list = integer_to_list(K),
    K_len = length(K_list),
    A_len = length(A),
    Max_len = max(K_len, A_len),
    add_to_array_form(A, K_list, 0, Max_len).

add_to_array_form(A, K, Carry, Max) when Max > 0 ->
    A_val = if Max > length(A) -> 0; true -> lists:nth(Max - length(A), A) end,
    K_val = if Max > length(K) -> 0; true -> list_to_integer(lists:nth(Max - length(K), K)) end,
    Sum = A_val + K_val + Carry,
    New_Carry = Sum div 10,
    New_Digit = Sum rem 10,
    [New_Digit | add_to_array_form(A, K, New_Carry, Max - 1)];
add_to_array_form(_, _, 0, 0) -> [].