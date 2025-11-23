-module(solution).
-export([totalFruit/1]).

totalFruit(Fruits) ->
    K = 3, %% Assuming 'III' implies at most 3 distinct fruit types
    Array = list_to_tuple(Fruits), %% Convert list to tuple for O(1) indexed access
    N = length(Fruits),
    solve(Array, N, K, 0, 0, maps:new(), 0).

solve(Array, N, K, Left, Right, FreqMap, MaxFruits) ->
    case Right < N of
        true ->
            FruitR = element(Right + 1, Array), %% Tuple elements are 1-indexed
            NewFreqMap1 = maps:update_with(FruitR, fun(Count) -> Count + 1 end, 1, FreqMap),

            {NewLeft, NewFreqMap2} = adjust_window(Array, K, Left, NewFreqMap1),

            CurrentWindowSize = Right - NewLeft + 1,
            NewMaxFruits = max(MaxFruits, CurrentWindowSize),

            solve(Array, N, K, NewLeft, Right + 1, NewFreqMap2, NewMaxFruits);
        false ->
            MaxFruits
    end.

adjust_window(Array, K, Left, FreqMap) ->
    case maps:size(FreqMap) > K of
        true ->
            FruitL = element(Left + 1, Array),
            CountL = maps:get(FruitL, FreqMap),
            NewFreqMap =
                case CountL - 1 of
                    0 -> maps:remove(FruitL, FreqMap);
                    NewCount -> maps:put(FruitL, NewCount, FreqMap)
                end,
            adjust_window(Array, K, Left + 1, NewFreqMap);
        false ->
            {Left, FreqMap}
    end.