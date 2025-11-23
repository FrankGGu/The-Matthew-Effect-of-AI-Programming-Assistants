-spec longest_palindrome_subseq(S :: unicode:unicode_binary(), K :: integer()) -> integer().
longest_palindrome_subseq(S, K) ->
    SList = unicode:characters_to_list(S),
    N = length(SList),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    DPWithK = array:new([{size, N}, {default, array:new([{size, N}, {default, array:new([{size, K+1}, {default, 0}])}])}]),
    {Ans, _} = solve(SList, 0, N-1, K, DP, DPWithK),
    Ans.

solve(S, I, J, K, DP, DPWithK) ->
    case I > J of
        true -> {0, DP, DPWithK};
        false ->
            case I =:= J of
                true -> {1, DP, DPWithK};
                false ->
                    case array:get(I, array:get(J, DP)) of
                        0 ->
                            {Res1, DP1, DPWithK1} = case lists:nth(I+1, S) =:= lists:nth(J+1, S) of
                                true ->
                                    {SubRes, DPSub, DPWithKSub} = solve(S, I+1, J-1, K, DP, DPWithK),
                                    {SubRes + 2, DPSub, DPWithKSub};
                                false ->
                                    {SubRes1, DP1_1, DPWithK1_1} = solve(S, I+1, J, K, DP, DPWithK),
                                    {SubRes2, DP1_2, DPWithK1_2} = solve(S, I, J-1, K, DP1_1, DPWithK1_1),
                                    {max(SubRes1, SubRes2), DP1_2, DPWithK1_2}
                            end,
                            DP2 = array:set(J, array:set(I, Res1, array:get(J, DP)), DP),
                            {Res1, DP2, DPWithK1};
                        Cached -> {Cached, DP, DPWithK}
                    end
            end
    end.

solve_with_k(S, I, J, K, DP, DPWithK) ->
    case I > J of
        true -> {0, DP, DPWithK};
        false ->
            case I =:= J of
                true -> {1, DP, DPWithK};
                false ->
                    case array:get(K+1, array:get(J, array:get(I, DPWithK))) of
                        0 ->
                            {Res1, DP1, DPWithK1} = case lists:nth(I+1, S) =:= lists:nth(J+1, S) of
                                true ->
                                    {SubRes, DPSub, DPWithKSub} = solve_with_k(S, I+1, J-1, K, DP, DPWithK),
                                    {SubRes + 2, DPSub, DPWithKSub};
                                false ->
                                    case K > 0 of
                                        true ->
                                            {SubRes1, DP1_1, DPWithK1_1} = solve_with_k(S, I+1, J-1, K-1, DP, DPWithK),
                                            {SubRes1 + 2, DP1_1, DPWithK1_1};
                                        false -> {0, DP, DPWithK}
                                    end
                            end,
                            {SubRes2, DP1_2, DPWithK1_2} = case K > 0 of
                                true ->
                                    {SubRes3, DP1_3, DPWithK1_3} = solve_with_k(S, I+1, J, K-1, DP1, DPWithK1),
                                    {SubRes4, DP1_4, DPWithK1_4} = solve_with_k(S, I, J-1, K-1, DP1_3, DPWithK1_3),
                                    {max(SubRes3, SubRes4), DP1_4, DPWithK1_4};
                                false -> {0, DP1, DPWithK1}
                            end,
                            {SubRes5, DP1_5, DPWithK1_5} = solve(S, I+1, J, K, DP1_2, DPWithK1_2),
                            {SubRes6, DP1_6, DPWithK1_6} = solve(S, I, J-1, K, DP1_5, DPWithK1_5),
                            Res = max(max(Res1, SubRes2), max(SubRes5, SubRes6)),
                            DPWithK2 = array:set(I, array:set(J, array:set(K+1, Res, array:get(J, array:get(I, DPWithK1_6))), array:get(I, DPWithK1_6)), DP1_6),
                            {Res, DP1_6, DPWithK2};
                        Cached -> {Cached, DP, DPWithK}
                    end
            end
    end.