-module(fruit_into_baskets).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    Maps = maps:new(),
    Left = 0,
    Right = 0,
    Max = 0,
    total_fruit(Fruits, Maps, Left, Right, Max).

total_fruit(Fruits, Maps, Left, Right, Max) ->
    if
        Right == length(Fruits) ->
            Max;
        true ->
            CurrentFruit = lists:nth(Right + 1, Fruits),
            NewMaps = maps:update_with(CurrentFruit, fun(V) -> V + 1 end, 1, Maps),
            if
                maps:size(NewMaps) > 2 ->
                    LeftFruit = lists:nth(Left + 1, Fruits),
                    UpdatedMaps = maps:update(LeftFruit, maps:get(LeftFruit, NewMaps) - 1, NewMaps),
                    if
                        maps:get(LeftFruit, UpdatedMaps) == 0 ->
                            maps:remove(LeftFruit, UpdatedMaps);
                        true ->
                            UpdatedMaps
                    end,
                    total_fruit(Fruits, UpdatedMaps, Left + 1, Right + 1, Max);
                true ->
                    total_fruit(Fruits, NewMaps, Left, Right + 1, max(Max, Right - Left + 1))
            end
    end.