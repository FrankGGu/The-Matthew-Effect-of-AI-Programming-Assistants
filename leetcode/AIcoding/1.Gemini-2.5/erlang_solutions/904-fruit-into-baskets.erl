-module(solution).
-export([total_fruit/1]).

total_fruit(FruitsList) ->
    FruitsArray = array:from_list(FruitsList),
    N = array:size(FruitsArray),
    solve(FruitsArray, N, 0, 0, maps:new(), 0).

solve(FruitsArray, N, Left, Right, CurrentMap, MaxFruits) when Right < N ->
    FruitRight = array:get(Right, FruitsArray),

    NewCurrentMap1 = maps:update_with(FruitRight, fun(Count) -> Count + 1 end, 1, CurrentMap),

    {NewLeft, NewCurrentMap2} = shrink_window(FruitsArray, Left, NewCurrentMap1),

    CurrentWindowSize = Right - NewLeft + 1,
    NewMaxFruits = max(MaxFruits, CurrentWindowSize),

    solve(FruitsArray, N, NewLeft, Right + 1, NewCurrentMap2, NewMaxFruits);

solve(_FruitsArray, _N, _Left, _Right, _CurrentMap, MaxFruits) ->
    MaxFruits.

shrink_window(FruitsArray, Left, CurrentMap) ->
    case maps:size(CurrentMap) > 2 of
        true ->
            FruitLeft = array:get(Left, FruitsArray),
            CountLeft = maps:get(FruitLeft, CurrentMap),

            NewCurrentMap = 
                case CountLeft - 1 of
                    0 -> maps:remove(FruitLeft, CurrentMap);
                    NewCount -> maps:put(FruitLeft, NewCount, CurrentMap)
                end,

            shrink_window(FruitsArray, Left + 1, NewCurrentMap);
        false ->
            {Left, CurrentMap}
    end.