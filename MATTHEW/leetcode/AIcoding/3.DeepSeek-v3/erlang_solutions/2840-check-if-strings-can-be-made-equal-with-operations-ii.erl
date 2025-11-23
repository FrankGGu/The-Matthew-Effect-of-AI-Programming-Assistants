-spec can_be_equal(s1 :: unicode:unicode_binary(), s2 :: unicode:unicode_binary()) -> boolean().
can_be_equal(S1, S2) ->
    case byte_size(S1) =/= byte_size(S2) of
        true -> false;
        false ->
            Even1 = lists:sort([binary:at(S1, I) || I <- lists:seq(0, byte_size(S1) - 1), I rem 2 =:= 0]),
            Even2 = lists:sort([binary:at(S2, I) || I <- lists:seq(0, byte_size(S2) - 1), I rem 2 =:= 0]),
            Odd1 = lists:sort([binary:at(S1, I) || I <- lists:seq(0, byte_size(S1) - 1), I rem 2 =/= 0]),
            Odd2 = lists:sort([binary:at(S2, I) || I <- lists:seq(0, byte_size(S2) - 1), I rem 2 =/= 0]),
            Even1 =:= Even2 andalso Odd1 =:= Odd2
    end.