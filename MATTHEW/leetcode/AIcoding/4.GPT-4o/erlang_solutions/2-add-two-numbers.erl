-spec add_two_numbers(L1 :: #list_node{} | null, L2 :: #list_node{} | null) -> #list_node{} | null.
add_two_numbers(L1, L2) ->
    add_two_numbers(L1, L2, 0).

add_two_numbers(null, null, 0) -> null;
add_two_numbers(null, #list_node{val = V, next = T}, Carry) ->
    case V + Carry of
        Sum when Sum >= 10 -> #list_node{val = Sum - 10, next = add_two_numbers(null, T, 1)};
        Sum -> #list_node{val = Sum, next = add_two_numbers(null, T, 0)}
    end;
add_two_numbers(#list_node{val = V, next = T}, null, Carry) ->
    case V + Carry of
        Sum when Sum >= 10 -> #list_node{val = Sum - 10, next = add_two_numbers(T, null, 1)};
        Sum -> #list_node{val = Sum, next = add_two_numbers(T, null, 0)}
    end;
add_two_numbers(#list_node{val = V1, next = T1}, #list_node{val = V2, next = T2}, Carry) ->
    case V1 + V2 + Carry of
        Sum when Sum >= 10 -> #list_node{val = Sum - 10, next = add_two_numbers(T1, T2, 1)};
        Sum -> #list_node{val = Sum, next = add_two_numbers(T1, T2, 0)}
    end.
