-spec num_distinct(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
num_distinct(S, T) ->
    S1 = unicode:characters_to_list(S),
    T1 = unicode:characters_to_list(T),
    M = length(S1),
    N = length(T1),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    DP1 = lists:map(fun(I) -> 
                        case I of
                            0 -> lists:duplicate(N + 1, 1);
                            _ -> [0 | lists:nthtail(1, lists:nth(I + 1, DP))]
                        end
                    end, lists:seq(0, M)),
    DP2 = lists:foldl(fun(I, AccI) ->
                        lists:foldl(fun(J, AccJ) ->
                                        case I > 0 andalso J > 0 of
                                            true ->
                                                Val = case lists:nth(I, S1) =:= lists:nth(J, T1) of
                                                        true -> 
                                                            lists:nth(J, lists:nth(I, AccI)) + 
                                                            lists:nth(J + 1, lists:nth(I, AccI));
                                                        false ->
                                                            lists:nth(J + 1, lists:nth(I, AccI))
                                                      end,
                                                Row = lists:sublist(AccJ, I),
                                                Row ++ [[lists:nth(J, lists:nth(I, AccI)) | [Val | lists:nthtail(J + 1, lists:nth(I, AccI))]]];
                                            false ->
                                                AccJ
                                        end
                                    end, AccI, lists:seq(1, N))
                      end, DP1, lists:seq(1, M)),
    lists:nth(N + 1, lists:nth(M + 1, DP2)).