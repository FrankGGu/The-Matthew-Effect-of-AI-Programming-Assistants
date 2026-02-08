-spec maximum_odd_binary_number(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
maximum_odd_binary_number(S) ->
    Ones = lists:sum([1 || <<"1">> <= S]),
    Zeros = byte_size(S) - Ones,
    case Ones of
        1 -> << <<"0">> || _ <- lists:seq(1, Zeros) >> ++ <<"1">>;
        _ -> << <<"1">> || _ <- lists:seq(1, Ones - 1) >> ++ << <<"0">> || _ <- lists:seq(1, Zeros) >> ++ <<"1">>
    end.