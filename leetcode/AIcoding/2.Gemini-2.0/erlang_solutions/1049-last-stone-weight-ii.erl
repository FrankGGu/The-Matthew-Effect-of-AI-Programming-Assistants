-module(last_stone_weight_ii).
-export([last_stone_weight_ii/1]).

last_stone_weight_ii(Stones) ->
    Sum = lists:sum(Stones),
    N = length(Stones),
    Target = Sum div 2,

    DP = array:new([0, Target + 1], {default, false}),
    array:set(0, DP, true),

    for(I, 1, N, fun(I) ->
        Stone = lists:nth(I - 1, Stones),
        for(J, Target, Stone, -1, fun(J) ->
            if
                array:get(J - Stone, DP) ->
                    array:set(J, DP, true);
                true ->
                    ok
            end
        end)
    end),

    Result = lists:foldl(fun(Idx, Acc) ->
        case array:get(Idx, DP) of
            true ->
                max(Acc, Idx);
            false ->
                Acc
        end
    end, 0, lists:seq(0,Target)),

    abs(Sum - 2 * Result).