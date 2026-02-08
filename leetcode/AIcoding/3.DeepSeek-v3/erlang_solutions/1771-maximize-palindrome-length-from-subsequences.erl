-spec longest_palindrome_subseq(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> integer().
longest_palindrome_subseq(Word1, Word2) ->
    W1 = binary_to_list(Word1),
    W2 = binary_to_list(Word2),
    Combined = W1 ++ W2,
    N = length(Combined),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    DP1 = fill_dp(Combined, DP, N),
    MaxLen = find_max_palindrome(W1, W2, Combined, DP1, N),
    MaxLen.

fill_dp(S, DP, N) ->
    lists:foldl(fun(I, AccDP) ->
        array:set(I, array:set(I, 1, array:get(I, AccDP)), AccDP)
    end, DP, lists:seq(0, N - 1)),
    lists:foldl(fun(Len, AccDP) ->
        lists:foldl(fun(I, DPAcc) ->
            J = I + Len,
            if
                J >= N -> DPAcc;
                true ->
                    case lists:nth(I + 1, S) =:= lists:nth(J + 1, S) of
                        true ->
                            Val = 2 + array:get(I + 1, array:get(J - 1, DPAcc)),
                            NewRow = array:set(J, Val, array:get(I, DPAcc)),
                            array:set(I, NewRow, DPAcc);
                        false ->
                            Val1 = array:get(I, array:get(J - 1, DPAcc)),
                            Val2 = array:get(I + 1, array:get(J, DPAcc)),
                            MaxVal = max(Val1, Val2),
                            NewRow = array:set(J, MaxVal, array:get(I, DPAcc)),
                            array:set(I, NewRow, DPAcc)
                    end
            end
        end, AccDP, lists:seq(0, N - Len - 1))
    end, DP, lists:seq(1, N - 1)).

find_max_palindrome(W1, W2, Combined, DP, N) ->
    Len1 = length(W1),
    MaxLen = 0,
    lists:foldl(fun(I, Max) ->
        lists:foldl(fun(J, CurrentMax) ->
            if
                I < Len1 andalso J >= Len1 andalso lists:nth(I + 1, Combined) =:= lists:nth(J + 1, Combined) ->
                    Len = case I + 1 =< J - 1 of
                        true -> array:get(I + 1, array:get(J - 1, DP));
                        false -> 0
                    end,
                    max(CurrentMax, 2 + Len);
                true -> CurrentMax
            end
        end, Max, lists:seq(0, N - 1))
    end, MaxLen, lists:seq(0, N - 1)).