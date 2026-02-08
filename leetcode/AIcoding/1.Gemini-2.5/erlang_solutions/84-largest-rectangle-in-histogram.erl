-module(solution).
-export([largestRectangleArea/1]).

largestRectangleArea(Heights) ->
    PaddedHeightsList = Heights ++ [0],
    HeightsArray = array:from_list(PaddedHeightsList),
    Len = array:size(HeightsArray),
    largest_rectangle_area_loop(HeightsArray, Len, 0, [], 0).

largest_rectangle_area_loop(HeightsArray, Len, Idx, Stack, MaxArea) when Idx < Len ->
    CurrentHeight = array:get(Idx, HeightsArray),
    {NewStack, UpdatedMaxArea} = pop_stack(HeightsArray, Idx, CurrentHeight, Stack, MaxArea),
    largest_rectangle_area_loop(HeightsArray, Len, Idx + 1, [Idx | NewStack], UpdatedMaxArea);
largest_rectangle_area_loop(_HeightsArray, _Len, _Idx, _Stack, MaxArea) ->
    MaxArea.

pop_stack(HeightsArray, CurrentIdx, CurrentHeight, Stack, AccMaxArea) ->
    case Stack of
        [] ->
            {[], AccMaxArea};
        [TopIdx | RestStack] ->
            TopHeight = array:get(TopIdx, HeightsArray),
            if TopHeight >= CurrentHeight ->
                Width = case RestStack of
                            [] -> CurrentIdx;
                            [PrevTopIdx | _] -> CurrentIdx - PrevTopIdx - 1
                        end,
                Area = TopHeight * Width,
                NewMaxArea = max(AccMaxArea, Area),
                pop_stack(HeightsArray, CurrentIdx, CurrentHeight, RestStack, NewMaxArea);
            true ->
                {Stack, AccMaxArea}
            end
    end.