-spec shortest_common_supersequence(Str1 :: unicode:unicode_binary(), Str2 :: unicode:unicode_binary()) -> unicode:unicode_binary().
shortest_common_supersequence(Str1, Str2) ->
    S1 = binary_to_list(Str1),
    S2 = binary_to_list(Str2),
    DP = dp_table(S1, S2),
    build_scs(S1, S2, DP).

dp_table(S1, S2) ->
    M = length(S1),
    N = length(S2),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            if
                I == 0 -> 
                    [Row | Rest] = AccJ,
                    [ [J | tl(Row)] | Rest ];
                J == 0 -> 
                    [Row | Rest] = AccJ,
                    [ [I | tl(Row)] | Rest ];
                true ->
                    [Row | Rest] = AccJ,
                    case lists:nth(I, S1) == lists:nth(J, S2) of
                        true ->
                            Prev = lists:nth(I, lists:nth(J, AccI)),
                            [ [Prev | tl(Row)] | Rest ];
                        false ->
                            Up = lists:nth(I, lists:nth(J + 1, AccJ)),
                            Left = lists:nth(I + 1, lists:nth(J, AccJ)),
                            [ [1 + min(Up, Left) | tl(Row)] | Rest ]
                    end
            end
        end, AccI, lists:seq(1, N))
    end, DP, lists:seq(1, M)).

build_scs(S1, S2, DP) ->
    M = length(S1),
    N = length(S2),
    build_scs(S1, S2, DP, M, N, []).

build_scs(_, _, _, 0, 0, Acc) ->
    list_to_binary(lists:reverse(Acc));
build_scs(S1, S2, DP, I, 0, Acc) ->
    build_scs(S1, S2, DP, I - 1, 0, [lists:nth(I, S1) | Acc]);
build_scs(S1, S2, DP, 0, J, Acc) ->
    build_scs(S1, S2, DP, 0, J - 1, [lists:nth(J, S2) | Acc]);
build_scs(S1, S2, DP, I, J, Acc) ->
    case lists:nth(I, S1) == lists:nth(J, S2) of
        true ->
            build_scs(S1, S2, DP, I - 1, J - 1, [lists:nth(I, S1) | Acc]);
        false ->
            Up = lists:nth(I, lists:nth(J + 1, DP)),
            Left = lists:nth(I + 1, lists:nth(J, DP)),
            if
                Up < Left ->
                    build_scs(S1, S2, DP, I - 1, J, [lists:nth(I, S1) | Acc]);
                true ->
                    build_scs(S1, S2, DP, I, J - 1, [lists:nth(J, S2) | Acc])
            end
    end.