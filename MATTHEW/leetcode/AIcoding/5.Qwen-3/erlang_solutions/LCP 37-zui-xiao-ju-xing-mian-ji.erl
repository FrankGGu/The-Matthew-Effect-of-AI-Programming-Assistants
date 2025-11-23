-module(min_rectangle_area).
-export([min_area/1]).

min_area(Points) ->
    PointsSorted = lists:sort(Points),
    Map = maps:new(),
    Maps = lists:foldl(fun(P, Acc) -> 
        Key = element(1, P),
        Value = element(2, P),
        maps:update_with(Key, fun(V) -> [Value | V] end, [Value], Acc)
    end, Map, PointsSorted),
    min_area(Maps, 0).

min_area(_Map, Min) when Min == 0 ->
    Min;
min_area(Map, Min) ->
    Keys = maps:keys(Map),
    min_area(Keys, Map, Min).

min_area([], _Map, Min) ->
    Min;
min_area([K1 | Rest], Map, Min) ->
    Values1 = maps:get(K1, Map),
    SortedValues1 = lists:sort(Values1),
    min_area_values(K1, SortedValues1, Rest, Map, Min).

min_area_values(_, [], _, _, Min) ->
    Min;
min_area_values(K1, [V1 | Vs1], Rest, Map, Min) ->
    min_area_values_pair(K1, V1, Rest, Map, Min, Vs1).

min_area_values_pair(_, _, [], _, Min, _) ->
    Min;
min_area_values_pair(K1, V1, [K2 | Rest], Map, Min, Vs1) ->
    Values2 = maps:get(K2, Map),
    SortedValues2 = lists:sort(Values2),
    min_area_values_pair_helper(K1, V1, SortedValues2, K2, Rest, Map, Min, Vs1).

min_area_values_pair_helper(_, _, [], _, _, _, Min, _) ->
    Min;
min_area_values_pair_helper(K1, V1, [V2 | Vs2], K2, Rest, Map, Min, Vs1) ->
    case lists:member(V2, Vs1) of
        true ->
            Area = (K2 - K1) * (V2 - V1),
            NewMin = if Area < Min -> Area; true -> Min end,
            min_area_values_pair_helper(K1, V1, Vs2, K2, Rest, Map, NewMin, Vs1);
        false ->
            min_area_values_pair_helper(K1, V1, Vs2, K2, Rest, Map, Min, Vs1)
    end.