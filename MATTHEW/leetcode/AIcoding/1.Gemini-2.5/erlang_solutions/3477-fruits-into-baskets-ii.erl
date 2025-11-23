-module(solution).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    % Initial call:
    % CurrentRightList: The full list, representing the remaining fruits to process for the right pointer.
    % CurrentLeftList: The full list, representing the remaining fruits for the left pointer to potentially remove.
    % LeftIdx: The 0-based index of the current 'LeftList' head in the original 'Fruits' list.
    % Map: The frequency map of fruits in the current window.
    % MaxLen: The maximum length found so far.
    % CurrentRightIdx: The 0-based index of the fruit currently being processed by the right pointer.
    solve(Fruits, Fruits, 0, #{}, 0, 0).

solve([], _CurrentLeftList, _LeftIdx, _Map, MaxLen, _CurrentRightIdx) ->
    MaxLen;
solve([FruitR | RestRight], CurrentLeftList, LeftIdx, Map, MaxLen, CurrentRightIdx) ->
    % 1. Expand window to the right by adding FruitR
    NewMap1 = maps:update_with(FruitR, fun(Count) -> Count + 1 end, 1, Map),

    % 2. Shrink window from the left if needed (more than 2 types)
    %    This returns the updated CurrentLeftList, LeftIdx, and Map.
    {NewCurrentLeftList, NewLeftIdx, NewMap2} = 
        shrink_window_list(CurrentLeftList, LeftIdx, NewMap1),

    % 3. Calculate current window length and update MaxLen
    CurrentWindowLen = CurrentRightIdx - NewLeftIdx + 1,
    NewMaxLen = max(MaxLen, CurrentWindowLen),

    % 4. Recurse for the next fruit on the right
    solve(RestRight, NewCurrentLeftList, NewLeftIdx, NewMap2, NewMaxLen, CurrentRightIdx + 1).

shrink_window_list(CurrentLeftList, LeftIdx, Map) when map_size(Map) =< 2 ->
    {CurrentLeftList, LeftIdx, Map};
shrink_window_list([FruitL | RestLeft], LeftIdx, Map) ->
    % Remove FruitL from Map
    CountL = maps:get(FruitL, Map),
    NewMap = if
                 CountL == 1 -> maps:remove(FruitL, Map);
                 true -> maps:update(FruitL, CountL - 1, Map)
             end,

    % Recurse with updated Left pointer
    shrink_window_list(RestLeft, LeftIdx + 1, NewMap).