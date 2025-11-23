-spec add_two_numbers(L1 :: #list_node{} | null, L2 :: #list_node{} | null) -> #list_node{} | null.
add_two_numbers(L1, L2) ->
    add_two_numbers(L1, L2, 0).

add_two_numbers(null, null, 0) ->
    null;
add_two_numbers(null, null, Carry) ->
    #list_node{val = Carry};
add_two_numbers(L1, null, Carry) ->
    Sum = get_val(L1) + Carry,
    #list_node{val = Sum rem 10, next = add_two_numbers(get_next(L1), null, Sum div 10)};
add_two_numbers(null, L2, Carry) ->
    Sum = get_val(L2) + Carry,
    #list_node{val = Sum rem 10, next = add_two_numbers(null, get_next(L2), Sum div 10)};
add_two_numbers(L1, L2, Carry) ->
    Sum = get_val(L1) + get_val(L2) + Carry,
    #list_node{val = Sum rem 10, next = add_two_numbers(get_next(L1), get_next(L2), Sum div 10)}.

get_val(null) -> 0;
get_val(#list_node{val = Val}) -> Val.

get_next(null) -> null;
get_next(#list_node{next = Next}) -> Next.