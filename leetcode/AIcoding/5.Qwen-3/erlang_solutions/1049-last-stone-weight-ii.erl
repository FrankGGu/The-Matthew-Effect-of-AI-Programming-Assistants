-module(last_stone_weight_ii).
-export([last_stone_weight_II/1]).

last_stone_weight_II(Stones) ->
    Sum = lists:sum(Stones),
    Target = Sum div 2,
    Max = knapsack(Stones, Target),
    Sum - 2 * Max.

knapsack(Stones, Target) ->
    {_, Max} = lists:foldl(fun(Stone, {DP, Max}) ->
        NewDP = lists:seq(0, Target),
        lists:foreach(fun(I) ->
            if I >= Stone ->
                NewDP = array:set(I, max(array:get(I, DP), array:get(I - Stone, DP)), NewDP);
            true -> ok
            end
        end, lists:seq(0, Target)),
        {NewDP, max(Max, array:get(Target, NewDP))}
    end, {array:new(Target + 1, {default, 0}), 0}, Stones),
    Max.