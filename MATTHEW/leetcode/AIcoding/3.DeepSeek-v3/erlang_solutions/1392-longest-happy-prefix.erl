-spec longest_prefix(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
longest_prefix(S) ->
    N = byte_size(S),
    Lps = lists:duplicate(N, 0),
    {Lps1, _} = lists:foldl(fun(I, {LpsAcc, Len}) ->
        case I > 1 andalso binary:at(S, I - 1) =/= binary:at(S, Len) of
            true ->
                Len1 = lists:nth(Len, LpsAcc),
                {lists:sublist(LpsAcc, I - 1) ++ [Len1] ++ lists:nthtail(I, LpsAcc), Len1};
            false ->
                case binary:at(S, I - 1) =:= binary:at(S, Len) of
                    true -> Len1 = Len + 1;
                    false -> Len1 = Len
                end,
                {lists:sublist(LpsAcc, I - 1) ++ [Len1] ++ lists:nthtail(I, LpsAcc), Len1}
        end
    end, {Lps, 0}, lists:seq(2, N)),
    Len = lists:last(Lps1),
    binary:part(S, 0, Len).