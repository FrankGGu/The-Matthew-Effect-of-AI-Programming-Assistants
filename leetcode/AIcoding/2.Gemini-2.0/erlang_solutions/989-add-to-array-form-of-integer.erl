-module(add_to_array_form).
-export([add_to_array_form/2]).

add_to_array_form(A, K) ->
    add_to_array_form_helper(A, integer_to_list(K), []).

add_to_array_form_helper([], [], Acc) ->
    lists:reverse(Acc);
add_to_array_form_helper([], K, Acc) ->
    add_to_array_form_helper([0], K, Acc);
add_to_array_form_helper(A, [], Acc) ->
    add_to_array_form_helper(A, [0], Acc);
add_to_array_form_helper(A, K, Acc) ->
    {Sum, Carry} = add_digits(lists:last(A), lists:last(K), 0),
    A1 = lists:droplast(A),
    K1 = lists:droplast(K),
    add_to_array_form_helper(A1, K1, [Sum | Acc]).

add_digits(A, B, Carry) ->
    Sum = list_to_integer([A]) + list_to_integer([B]) + Carry,
    if
        Sum >= 10 ->
            {Sum - 10, 1};
        true ->
            {Sum, 0}
    end.

integer_to_list(N) ->
    integer_to_list_helper(N, []).

integer_to_list_helper(0, Acc) ->
    if
        Acc == [] ->
            [0];
        true ->
            lists:reverse(Acc)
    end;
integer_to_list_helper(N, Acc) ->
    integer_to_list_helper(N div 10, [N rem 10 | Acc]).