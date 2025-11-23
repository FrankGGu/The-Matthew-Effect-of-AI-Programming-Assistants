-spec strange_printer(S :: unicode:unicode_binary()) -> integer().
strange_printer(S) ->
    case S of
        <<>> -> 0;
        _ ->
            N = byte_size(S),
            DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
            solve(0, N - 1, S, DP)
    end.

solve(I, J, S, DP) ->
    case I > J of
        true -> 0;
        false ->
            case array:get(I, array:get(J, DP)) of
                0 ->
                    Ans = case I == J of
                        true -> 1;
                        false ->
                            case binary:at(S, I) == binary:at(S, J) of
                                true -> solve(I, J - 1, S, DP);
                                false ->
                                    lists:min(lists:map(
                                        fun(K) -> solve(I, K, S, DP) + solve(K + 1, J, S, DP) end,
                                        lists:seq(I, J - 1)))
                            end
                    end,
                    NewRow = array:set(I, Ans, array:get(J, DP)),
                    NewDP = array:set(J, NewRow, DP),
                    Ans;
                Val -> Val
            end
    end.