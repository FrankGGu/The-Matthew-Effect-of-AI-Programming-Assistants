-spec count_substrings(S :: unicode:unicode_binary()) -> integer().
count_substrings(S) ->
    N = byte_size(S),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, false}])}]),
    Count = lists:foldl(
        fun(I, Acc) ->
            array:set(I, array:set(I, true, array:get(I, DP)), DP),
            Acc1 = if I < N - 1 andalso binary:at(S, I) =:= binary:at(S, I + 1) ->
                array:set(I, array:set(I + 1, true, array:get(I, DP)), DP),
                Acc + 1;
                true -> Acc
            end,
            Acc1
        end,
        N,
        lists:seq(0, N - 1)
    ),
    lists:foldl(
        fun(Len, Acc) ->
            lists:foldl(
                fun(I, InnerAcc) ->
                    J = I + Len - 1,
                    if J < N andalso binary:at(S, I) =:= binary:at(S, J) andalso array:get(I + 1, array:get(J - 1, DP)) ->
                        array:set(I, array:set(J, true, array:get(I, DP)), DP),
                        InnerAcc + 1;
                    true -> InnerAcc
                    end
                end,
                Acc,
                lists:seq(0, N - Len)
        end,
        Count,
        lists:seq(3, N)
    ).