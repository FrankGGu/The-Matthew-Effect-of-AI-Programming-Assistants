-spec add_negabinary(Arr1 :: [integer()], Arr2 :: [integer()]) -> [integer()].
add_negabinary(Arr1, Arr2) ->
    A = lists:reverse(Arr1),
    B = lists:reverse(Arr2),
    MaxLen = max(length(A), length(B)),
    PaddedA = A ++ lists:duplicate(MaxLen - length(A), 0),
    PaddedB = B ++ lists:duplicate(MaxLen - length(B), 0),
    add(PaddedA, PaddedB, 0, []).

add([], [], 0, Acc) ->
    case Acc of
        [] -> [0];
        _ -> lists:reverse(Acc)
    end;
add([], [], Carry, Acc) ->
    add([Carry], [], 0, Acc);
add([], B, Carry, Acc) ->
    add([Carry], B, 0, Acc);
add(A, [], Carry, Acc) ->
    add(A, [Carry], 0, Acc);
add([A | As], [B | Bs], Carry, Acc) ->
    Sum = A + B + Carry,
    case Sum of
        -1 ->
            add(As, Bs, 1, [1 | Acc]);
        0 ->
            add(As, Bs, 0, [0 | Acc]);
        1 ->
            add(As, Bs, 0, [1 | Acc]);
        2 ->
            add(As, Bs, -1, [0 | Acc]);
        3 ->
            add(As, Bs, -1, [1 | Acc])
    end.