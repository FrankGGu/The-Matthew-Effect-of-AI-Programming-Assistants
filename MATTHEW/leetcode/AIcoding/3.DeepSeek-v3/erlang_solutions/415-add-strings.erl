-spec add_strings(Num1 :: unicode:unicode_binary(), Num2 :: unicode:unicode_binary()) -> unicode:unicode_binary().
add_strings(Num1, Num2) ->
    add_strings(binary_to_list(Num1), binary_to_list(Num2), 0, []).

add_strings([], [], 0, Acc) ->
    list_to_binary(lists:reverse(Acc));
add_strings([], [], Carry, Acc) ->
    add_strings([], [], 0, [Carry + $0 | Acc]);
add_strings([], [H2 | T2], Carry, Acc) ->
    Sum = (H2 - $0) + Carry,
    add_strings([], T2, Sum div 10, [Sum rem 10 + $0 | Acc]);
add_strings([H1 | T1], [], Carry, Acc) ->
    Sum = (H1 - $0) + Carry,
    add_strings(T1, [], Sum div 10, [Sum rem 10 + $0 | Acc]);
add_strings([H1 | T1], [H2 | T2], Carry, Acc) ->
    Sum = (H1 - $0) + (H2 - $0) + Carry,
    add_strings(T1, T2, Sum div 10, [Sum rem 10 + $0 | Acc]).