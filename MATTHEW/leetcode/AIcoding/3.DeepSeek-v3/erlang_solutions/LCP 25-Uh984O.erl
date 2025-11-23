-spec keyboard(k :: integer(), n :: integer()) -> integer().
keyboard(K, N) ->
    Mod = 1000000007,
    DP = lists:duplicate(N + 1, lists:duplicate(K + 1, 0)),
    DP1 = lists:map(fun(I) -> 
                        case I of
                            0 -> lists:duplicate(K + 1, 1);
                            _ -> lists:duplicate(K + 1, 0)
                        end
                    end, lists:seq(0, N)),
    DP2 = lists:foldl(fun(I, Acc) ->
                        lists:foldl(fun(J, Acc1) ->
                            case I > 0 andalso J > 0 of
                                true ->
                                    Val = (lists:nth(I, Acc1) ++ 
                                           [ (lists:nth(J - 1, lists:nth(I - 1, Acc1)) + 
                                             (if I >= J -> lists:nth(J, lists:nth(I - J, Acc1)); true -> 0 end) rem Mod ]),
                                    lists:sublist(Acc1, I - 1) ++ [Val] ++ lists:nthtail(I, Acc1);
                                false ->
                                    Acc1
                            end
                        end, Acc, lists:seq(1, K))
                    end, DP1, lists:seq(1, N)),
    lists:nth(K, lists:nth(N + 1, DP2)) rem Mod.