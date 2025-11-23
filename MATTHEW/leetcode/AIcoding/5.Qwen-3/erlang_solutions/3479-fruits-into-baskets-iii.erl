-module(fruits_into_baskets_iii).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    Map = maps:new(),
    Left = 0,
    Right = 0,
    MaxLength = 0,
    total_fruit(Fruits, Map, Left, Right, MaxLength).

total_fruit(Fruits, Map, Left, Right, MaxLength) when Right == length(Fruits) ->
    MaxLength;
total_fruit(Fruits, Map, Left, Right, MaxLength) ->
    CurrentFruit = lists:nth(Right + 1, Fruits),
    NewMap = maps:update_with(CurrentFruit, fun(V) -> V + 1 end, 1, Map),
    case maps:size(NewMap) of
        Size when Size =< 2 ->
            NewMaxLength = max(MaxLength, Right - Left + 1),
            total_fruit(Fruits, NewMap, Left, Right + 1, NewMaxLength);
        _ ->
            LeftFruit = lists:nth(Left + 1, Fruits),
            UpdatedMap = maps:update(LeftFruit, maps:get(LeftFruit, NewMap) - 1, NewMap),
            if
                maps:get(LeftFruit, UpdatedMap) == 0 ->
                    UpdatedMap2 = maps:remove(LeftFruit, UpdatedMap);
                true ->
                    UpdatedMap2 = UpdatedMap
            end,
            total_fruit(Fruits, UpdatedMap2, Left + 1, Right, MaxLength)
    end.