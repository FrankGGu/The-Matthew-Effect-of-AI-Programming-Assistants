-spec add_binary(A :: unicode:unicode_binary(), B :: unicode:unicode_binary()) -> unicode:unicode_binary().
add_binary(A, B) ->
    add_binary(A, B, 0, <<>>).

add_binary(<<>>, <<>>, 0, Acc) -> Acc;
add_binary(<<>>, <<B::1/unit:8, RestB/binary>>, Carry, Acc) when Carry =:= 0 -> 
    add_binary(<<>>, RestB, 0, <<B:1/unit:8, Acc/binary>>);
add_binary(<<A::1/unit:8, RestA/binary>>, <<>>, Carry, Acc) when Carry =:= 0 ->
    add_binary(RestA, <<>>, 0, <<A:1/unit:8, Acc/binary>>);
add_binary(<<A::1/unit:8, RestA/binary>>, <<B::1/unit:8, RestB/binary>>, Carry, Acc) ->
    Sum = A + B + Carry,
    NewCarry = Sum div 2,
    add_binary(RestA, RestB, NewCarry, <<Sum rem 2:1/unit:8, Acc/binary>>).
