-spec watering_plants(Plants :: [integer()], Capacity :: integer()) -> integer().
watering_plants(Plants, Capacity) ->
    watering_plants(Plants, Capacity, Capacity, 0, 0).

watering_plants([], _, _, Steps, _) ->
    Steps;
watering_plants([Plant | Rest], Capacity, Current, Steps, Pos) ->
    if
        Current >= Plant ->
            watering_plants(Rest, Capacity, Current - Plant, Steps + 1, Pos + 1);
        true ->
            StepsToRiver = Pos * 2,
            watering_plants([Plant | Rest], Capacity, Capacity, Steps + StepsToRiver, 0)
    end.