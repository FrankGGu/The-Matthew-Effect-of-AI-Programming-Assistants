-spec add_binary(A :: unicode:unicode_binary(), B :: unicode:unicode_binary()) -> unicode:unicode_binary().
add_binary(A, B) ->
    add_binary(lists:reverse(binary_to_list(A)), lists:reverse(binary_to_list(B)), 0, []).

add_binary([], [], 0, Acc) ->
    list_to_binary(Acc);
add_binary([], [], 1, Acc) ->
    list_to_binary([$1 | Acc]);
add_binary([], B, Carry, Acc) ->
    add_binary([], tl(B), (hd(B) - $0 + Carry) div 2, [((hd(B) - $0 + Carry) rem 2) + $0 | Acc]);
add_binary(A, [], Carry, Acc) ->
    add_binary(tl(A), [], (hd(A) - $0 + Carry) div 2, [((hd(A) - $0 + Carry) rem 2) + $0 | Acc]);
add_binary(A, B, Carry, Acc) ->
    Sum = (hd(A) - $0) + (hd(B) - $0) + Carry,
    add_binary(tl(A), tl(B), Sum div 2, [(Sum rem 2) + $0 | Acc]).