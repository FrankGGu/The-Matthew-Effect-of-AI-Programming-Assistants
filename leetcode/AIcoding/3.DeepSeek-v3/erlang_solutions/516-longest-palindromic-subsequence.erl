-spec longest_palindrome_subseq(S :: unicode:unicode_binary()) -> integer().
longest_palindrome_subseq(S) ->
    N = byte_size(S),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    lists:foldl(
        fun(I, _) ->
            array:set(I, array:set(I, 1, array:get(I, DP)), DP),
            lists:foldl(
                fun(J, _) ->
                    I1 = I - 1,
                    J1 = J + 1,
                    case I1 >= 0 andalso J1 < N of
                        true ->
                            case binary:at(S, I1) =:= binary:at(S, J1) of
                                true ->
                                    Val = array:get(I1, array:get(J1, DP)) + 2,
                                    array:set(I, array:set(J, Val, array:get(I, DP)), DP);
                                false ->
                                    Val1 = array:get(I, array:get(J1, DP)),
                                    Val2 = array:get(I1, array:get(J, DP)),
                                    MaxVal = max(Val1, Val2),
                                    array:set(I, array:set(J, MaxVal, array:get(I, DP)), DP)
                            end;
                        false -> ok
                    end
                end,
                ok,
                lists:seq(0, N - 1 - I)
            )
        end,
        DP,
        lists:seq(1, N - 1)
    ),
    array:get(0, array:get(N - 1, DP)).