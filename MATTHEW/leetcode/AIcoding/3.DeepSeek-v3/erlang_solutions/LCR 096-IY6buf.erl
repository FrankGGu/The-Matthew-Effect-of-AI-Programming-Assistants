-spec is_interleave(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary(), S3 :: unicode:unicode_binary()) -> boolean().
is_interleave(S1, S2, S3) ->
    Len1 = byte_size(S1),
    Len2 = byte_size(S2),
    Len3 = byte_size(S3),
    if
        Len1 + Len2 =/= Len3 -> false;
        true ->
            DP = lists:foldl(fun(I, Acc) ->
                maps:put({I, 0}, (I == 0) orelse (I > 0 andalso maps:get({I - 1, 0}, Acc) andalso binary:at(S1, I - 1) == binary:at(S3, I - 1)), Acc)
            end, maps:new(), lists:seq(0, Len1)),
            DP2 = lists:foldl(fun(J, Acc) ->
                maps:put({0, J}, (J == 0) orelse (J > 0 andalso maps:get({0, J - 1}, Acc) andalso binary:at(S2, J - 1) == binary:at(S3, J - 1)), Acc)
            end, DP, lists:seq(0, Len2)),
            FinalDP = lists:foldl(fun(I, Acc1) ->
                lists:foldl(fun(J, Acc2) ->
                    Char = binary:at(S3, I + J - 1),
                    Case1 = I > 0 andalso maps:get({I - 1, J}, Acc2) andalso binary:at(S1, I - 1) == Char,
                    Case2 = J > 0 andalso maps:get({I, J - 1}, Acc2) andalso binary:at(S2, J - 1) == Char,
                    maps:put({I, J}, Case1 orelse Case2, Acc2)
                end, Acc1, lists:seq(1, Len2))
            end, DP2, lists:seq(1, Len1)),
            maps:get({Len1, Len2}, FinalDP)
    end.