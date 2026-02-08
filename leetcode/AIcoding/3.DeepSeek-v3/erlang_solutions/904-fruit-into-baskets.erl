-spec total_fruit(Fruits :: [integer()]) -> integer().
total_fruit(Fruits) ->
    SlidingWindow = fun SlidingWindow(Start, MaxCount, CountMap, FruitsList, MaxLength) ->
        case FruitsList of
            [] ->
                MaxLength;
            [Fruit | Rest] ->
                NewCountMap = maps:update_with(Fruit, fun(V) -> V + 1 end, 1, CountMap),
                NewCount = maps:size(NewCountMap),
                case NewCount =< 2 of
                    true ->
                        NewMaxLength = max(MaxLength, MaxCount + 1),
                        SlidingWindow(Start, MaxCount + 1, NewCountMap, Rest, NewMaxLength);
                    false ->
                        FirstFruit = lists:nth(Start + 1, Fruits),
                        OldCount = maps:get(FirstFruit, CountMap),
                        case OldCount of
                            1 ->
                                UpdatedCountMap = maps:remove(FirstFruit, CountMap);
                            _ ->
                                UpdatedCountMap = maps:update(FirstFruit, OldCount - 1, CountMap)
                        end,
                        SlidingWindow(Start + 1, MaxCount - 1, UpdatedCountMap, FruitsList, MaxLength)
                end
        end
    end,
    SlidingWindow(0, 0, #{}, Fruits, 0).