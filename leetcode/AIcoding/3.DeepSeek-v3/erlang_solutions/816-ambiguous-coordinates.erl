-spec ambiguous_coordinates(S :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
ambiguous_coordinates(S) ->
    S1 = binary_to_list(S),
    S2 = string:slice(S1, 1, length(S1) - 2),
    N = length(S2),
    Result = lists:foldl(
        fun(I, Acc) ->
            Left = string:slice(S2, 0, I),
            Right = string:slice(S2, I, N - I),
            LeftValid = generate(Left),
            RightValid = generate(Right),
            case {LeftValid, RightValid} of
                {[], _} -> Acc;
                {_, []} -> Acc;
                {L, R} ->
                    Combinations = lists:flatmap(
                        fun(L1) ->
                            lists:map(
                                fun(R1) ->
                                    list_to_binary(["(", L1, ", ", R1, ")"])
                                end,
                                R
                            )
                        end,
                        L
                    ),
                    lists:append(Acc, Combinations)
            end
        end,
        [],
        lists:seq(1, N)
    ),
    Result.

generate(S) ->
    N = length(S),
    case N of
        1 -> [S];
        _ ->
            case string:left(S, 1) of
                "0" ->
                    case string:right(S, 1) of
                        "0" -> [];
                        _ -> 
                            ["0." ++ string:slice(S, 1, N - 1)]
                    end;
                _ ->
                    case string:right(S, 1) of
                        "0" -> [S];
                        _ ->
                            lists:append(
                                [S],
                                lists:map(
                                    fun(I) ->
                                        string:slice(S, 0, I) ++ "." ++ string:slice(S, I, N - I)
                                    end,
                                    lists:seq(1, N - 1)
                                )
                            )
                    end
            end
    end.