-spec total_fruit(Fruits :: [integer()]) -> integer().
total_fruit(Fruits) ->
    total_fruit(Fruits, #{}, 0, 0, 0).

total_fruit([], _, _, Start, Max) ->
    max(Max, length(Fruits) - Start);
total_fruit([Fruit | Rest], Map, Count, Start, Max) ->
    case maps:is_key(Fruit, Map) of
        true ->
            NewMap = maps:update_with(Fruit, fun(V) -> V + 1 end, Map),
            total_fruit(Rest, NewMap, Count + 1, Start, Max);
        false when map_size(Map) < 2 ->
            NewMap = maps:put(Fruit, 1, Map),
            total_fruit(Rest, NewMap, Count + 1, Start, Max);
        false ->
            NewMax = max(Max, Count),
            {NewStart, NewMap} = remove_until(Rest, Start, Map),
            total_fruit(Rest, NewMap, length(Fruits) - NewStart, NewStart, NewMax)
    end.

remove_until(Fruits, Start, Map) ->
    remove_until(Fruits, Start, Map, Start).

remove_until([Fruit | Rest], Index, Map, Start) ->
    case maps:get(Fruit, Map) of
        1 ->
            NewMap = maps:remove(Fruit, Map),
            {Index + 1, NewMap};
        N ->
            NewMap = maps:put(Fruit, N - 1, Map),
            remove_until(Rest, Index + 1, NewMap, Start)
    end.