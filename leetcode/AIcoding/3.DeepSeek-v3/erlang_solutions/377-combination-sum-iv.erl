-spec combination_sum4(Nums :: [integer()], Target :: integer()) -> integer().
combination_sum4(Nums, Target) ->
    DP = maps:new(),
    DP1 = maps:put(0, 1, DP),
    combination_sum4(Nums, Target, DP1).

combination_sum4(_Nums, Target, DP) ->
    case maps:is_key(Target, DP) of
        true -> maps:get(Target, DP);
        false ->
            Count = lists:foldl(
                fun(Num, Acc) ->
                    case Target - Num of
                        T when T >= 0 ->
                            Acc + combination_sum4(_Nums, T, DP);
                        _ ->
                            Acc
                    end
                end,
                0,
                _Nums
            ),
            DP1 = maps:put(Target, Count, DP),
            Count
    end.