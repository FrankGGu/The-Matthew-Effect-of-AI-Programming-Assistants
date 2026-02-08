-module(fruits_into_baskets).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    total_fruit(Fruits, 0, 0, dict:new(), 0).

total_fruit([], _Start, _End, _FruitCount, Max) ->
    Max;
total_fruit([Fruit | Rest], Start, End, FruitCount, Max) ->
    case dict:is_key(Fruit, FruitCount) of
        true ->
            NewFruitCount = dict:update(Fruit, fun(V) -> V + 1 end, FruitCount),
            NewMax = max(Max, End - Start + 1),
            total_fruit(Rest, Start, End + 1, NewFruitCount, NewMax);
        false ->
            case dict:size(FruitCount) of
                2 ->
                    % Remove the oldest fruit
                    OldestFruit = get_oldest_fruit(FruitCount, Start),
                    NewFruitCount = dict:update(OldestFruit, fun(V) -> V - 1 end, FruitCount),
                    if
                        dict:fetch(OldestFruit, NewFruitCount) == 0 ->
                            NewFruitCount2 = dict:erase(OldestFruit, NewFruitCount);
                        true ->
                            NewFruitCount2 = NewFruitCount
                    end,
                    total_fruit(Rest, Start + 1, End + 1, NewFruitCount2, Max);
                _ ->
                    NewFruitCount = dict:store(Fruit, 1, FruitCount),
                    NewMax = max(Max, End - Start + 1),
                    total_fruit(Rest, Start, End + 1, NewFruitCount, NewMax)
            end
    end.

get_oldest_fruit(Dict, Start) ->
    lists:nth(1, dict:keys(Dict)).