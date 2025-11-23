-spec is_interleave(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary(), S3 :: unicode:unicode_binary()) -> boolean().
is_interleave(S1, S2, S3) ->
    Len1 = byte_size(S1),
    Len2 = byte_size(S2),
    Len3 = byte_size(S3),
    if
        Len1 + Len2 =/= Len3 -> false;
        true ->
            DP = array:new([{size, Len1 + 1}, {default, array:new([{size, Len2 + 1}, {default, false}])}]),
            DP1 = array:set(0, array:set(0, true, array:get(0, DP)), DP),
            DP2 = lists:foldl(fun(I, Acc) ->
                case I > 0 andalso binary:at(S1, I - 1) =:= binary:at(S3, I - 1) of
                    true -> array:set(I, array:set(0, array:get(I - 1, array:get(0, Acc)), Acc);
                    false -> Acc
                end
            end, DP1, lists:seq(1, Len1)),
            DP3 = lists:foldl(fun(J, Acc) ->
                case J > 0 andalso binary:at(S2, J - 1) =:= binary:at(S3, J - 1) of
                    true -> array:set(0, array:set(J, array:get(J - 1, array:get(0, Acc)), array:get(0, Acc)), Acc);
                    false -> Acc
                end
            end, DP2, lists:seq(1, Len2)),
            DP4 = lists:foldl(fun(I, Acc1) ->
                lists:foldl(fun(J, Acc2) ->
                    case (I > 0 andalso binary:at(S1, I - 1) =:= binary:at(S3, I + J - 1) andalso array:get(J, array:get(I - 1, Acc2))) orelse
                         (J > 0 andalso binary:at(S2, J - 1) =:= binary:at(S3, I + J - 1) andalso array:get(J - 1, array:get(I, Acc2))) of
                        true -> array:set(I, array:set(J, true, array:get(I, Acc2)), Acc2);
                        false -> Acc2
                    end
                end, Acc1, lists:seq(1, Len2))
            end, DP3, lists:seq(1, Len1)),
            array:get(Len2, array:get(Len1, DP4))
    end.