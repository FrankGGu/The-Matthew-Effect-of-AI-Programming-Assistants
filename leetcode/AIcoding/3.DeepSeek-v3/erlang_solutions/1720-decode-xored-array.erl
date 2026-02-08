-spec decode(Encoded :: [integer()], First :: integer()) -> [integer()].
decode(Encoded, First) ->
    decode_helper(Encoded, [First]).

decode_helper([], Acc) ->
    lists:reverse(Acc);
decode_helper([H|T], [Prev|_]=Acc) ->
    Next = H bxor Prev,
    decode_helper(T, [Next|Acc]).