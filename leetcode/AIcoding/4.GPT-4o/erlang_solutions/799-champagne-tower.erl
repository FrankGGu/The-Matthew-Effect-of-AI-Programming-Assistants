-module(solution).
-export([champagne_tower/3]).

champagne_tower(N, K, V) ->
    Tower = lists:duplicate(N + 1, lists:duplicate(N + 1, 0.0)),
    Tower = fill_tower(Tower, N, K, V),
    case lists:nth(N + 1, lists:nth(K + 1, Tower)) of
        Val when Val > 1.0 -> 1.0;
        Val -> Val
    end.

fill_tower(Tower, N, K, V) ->
    Tower = lists:update_element(1, lists:update_element(1, V, lists:nth(1, Tower)), Tower),
    fill_tower_helper(Tower, N, K).

fill_tower_helper(Tower, N, K) ->
    lists:foldl(fun(_, Acc) -> pour(Acc, N) end, Tower, lists:seq(1, N)),
    lists:nth(K + 1, lists:nth(N + 1, Tower)).

pour(Tower, N) ->
    lists:foldl(fun(X, Acc) -> pour_level(X, Acc, N) end, Tower, lists:seq(1, N)).

pour_level(X, Tower, N) ->
    case lists:nth(X, Tower) of
        Row when Row > 1.0 ->
            OverFlow = (Row - 1.0) / 2.0,
            Tower1 = lists:update_element(X, 1.0, Tower),
            pour_to_next_level(X + 1, OverFlow, Tower1, N);
        _ -> Tower
    end.

pour_to_next_level(_, _, Tower, 0) -> Tower;
pour_to_next_level(Level, OverFlow, Tower, N) ->
    if Level > N -> Tower;
    true -> 
        Tower1 = lists:update_element(Level, 
            lists:nth(Level, Tower) + OverFlow, Tower),
        pour_to_next_level(Level + 1, OverFlow, Tower1, N)
    end.