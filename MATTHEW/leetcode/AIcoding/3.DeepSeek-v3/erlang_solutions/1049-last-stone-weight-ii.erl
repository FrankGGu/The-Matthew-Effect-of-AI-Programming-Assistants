-spec last_stone_weight_ii(Stones :: [integer()]) -> integer().
last_stone_weight_ii(Stones) ->
    Sum = lists:sum(Stones),
    Half = Sum div 2,
    DP = lists:foldl(fun(Stone, Acc) ->
        lists:foldl(fun(J, Dp) ->
            if
                J >= Stone -> max(maps:get(J, Dp, 0), maps:get(J - Stone, Dp, 0) + Stone);
                true -> maps:get(J, Dp, 0)
            end
        end, Acc, lists:seq(Half, Stone, -1))
    end, #{0 => 0}, Stones),
    Sum - 2 * maps:get(Half, DP, 0).