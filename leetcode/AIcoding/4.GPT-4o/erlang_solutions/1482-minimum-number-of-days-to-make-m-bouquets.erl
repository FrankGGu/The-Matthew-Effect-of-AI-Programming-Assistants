-module(solution).
-export([minDays/3]).

minDays(Roses, m, k) ->
    Low = 1,
    High = lists:max(Roses),
    min_days_helper(Low, High, Roses, m, k).

min_days_helper(Low, High, Roses, m, k) when Low < High ->
    Mid = (Low + High) div 2,
    if
        can_make_bouquets(Roses, Mid, m, k) ->
            min_days_helper(Low, Mid, Roses, m, k);
        true ->
            min_days_helper(Mid + 1, High, Roses, m, k)
    end;
min_days_helper(Low, Low, _, _, _) ->
    Low.

can_make_bouquets(Roses, Days, M, K) ->
    lists:foldl(fun(X, Acc) ->
        Acc + (X div Days)
    end, 0, Roses) >= M.