-spec combination_sum4(Nums :: [integer()], Target :: integer()) -> integer().
combination_sum4(Nums, Target) ->
    DP = array:new(Target + 1, {default, 0}),
    DP1 = array:set(0, 1, DP),
    combination_sum4(Nums, Target, DP1).

combination_sum4(Nums, Target, DP) ->
    case Target < 0 of
        true -> 0;
        false ->
            case array:get(Target, DP) of
                0 ->
                    Res = lists:foldl(fun(Num, Acc) ->
                        Acc + combination_sum4(Nums, Target - Num, DP)
                    end, 0, Nums),
                    array:set(Target, Res, DP),
                    Res;
                Val -> Val
            end
    end.