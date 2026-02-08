-spec roman_to_int(S :: unicode:unicode_binary()) -> integer().
roman_to_int(S) ->
    RomanMap = #{<<"I">> => 1, <<"V">> => 5, <<"X">> => 10, <<"L">> => 50,
                 <<"C">> => 100, <<"D">> => 500, <<"M">> => 1000},
    roman_to_int(S, RomanMap, 0, 0).

roman_to_int(<<>>, _RomanMap, Prev, Acc) ->
    Acc;
roman_to_int(<<C:1/binary, Rest/binary>>, RomanMap, Prev, Acc) ->
    Current = maps:get(C, RomanMap),
    if
        Current > Prev ->
            NewAcc = Acc - Prev + (Current - Prev);
        true ->
            NewAcc = Acc + Current
    end,
    roman_to_int(Rest, RomanMap, Current, NewAcc).