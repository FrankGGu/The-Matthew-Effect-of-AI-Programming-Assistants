-module(solution).
-export([maximalRectangle/1]).

maximalRectangle(Matrix) ->
    maximalRectangle_impl(Matrix, [], 0).

maximalRectangle_impl([], _CurrentHeights, MaxArea) ->
    MaxArea;
maximalRectangle_impl([Row|RestMatrix], PrevHeights, MaxAreaSoFar) ->
    CurrentHeights = calculate_current_heights(Row, PrevHeights),
    AreaFromRow = largestRectangleArea(CurrentHeights),
    NewMaxArea = max(MaxAreaSoFar, AreaFromRow),
    maximalRectangle_impl(RestMatrix, CurrentHeights, NewMaxArea).

calculate_current_heights(Row, PrevHeights) ->
    calculate_current_heights_impl(Row, PrevHeights, []).

calculate_current_heights_impl([], [], Acc) ->
    lists:reverse(Acc);
calculate_current_heights_impl([C|CRest], [PH|PHRest], Acc) ->
    Height = case C of
                 $1' -> PH + 1;
                 $0' -> 0
             end,
    calculate_current_heights_impl(CRest, PHRest, [Height|Acc]);
calculate_current_heights_impl([C|CRest], [], Acc) -> % First row, PrevHeights is empty
    Height = case C of
                 $1' -> 1;
                 $0' -> 0
             end,
    calculate_current_heights_impl(CRest, [], [Height|Acc]).

largestRectangleArea(Heights) ->
    % Append 0 to ensure all elements in stack are processed
    % Stack stores {Height, Index} tuples
    largestRectangleArea_stack(Heights ++ [0], 0, [], 0).

largestRectangleArea_stack([], _Index, _Stack, MaxArea) -> % Should not be reached if HeightsList ends with 0
    MaxArea;
largestRectangleArea_stack([H|T], Index, Stack, MaxArea) ->
    {NewStack, CurrentMaxArea, ActualIndexToPush} = pop_and_calculate_lrh_optimized(H, Index, Stack, MaxArea),
    largestRectangleArea_stack(T, Index + 1, [{H, ActualIndexToPush} | NewStack], CurrentMaxArea).

pop_and_calculate_lrh_optimized(CurrentH, CurrentIdx, Stack, MaxArea) ->
    pop_and_calculate_lrh_optimized_loop(CurrentH, CurrentIdx, Stack, MaxArea, CurrentIdx).

pop_and_calculate_lrh_optimized_loop(CurrentH, CurrentIdx, [{TopH, TopIdx}|RestStack], CurrentMaxArea, LastPoppedIdx) when CurrentH < TopH ->
    Width = CurrentIdx - TopIdx,
    Area = TopH * Width,
    NewMaxArea = max(CurrentMaxArea, Area),
    pop_and_calculate_lrh_optimized_loop(CurrentH, CurrentIdx, RestStack, NewMaxArea, TopIdx);
pop_and_calculate_lrh_optimized_loop(_CurrentH, _CurrentIdx, Stack, CurrentMaxArea, LastPoppedIdx) ->
    % Stop popping, return remaining stack, max area, and the effective index for the current bar
    {Stack, CurrentMaxArea, LastPoppedIdx}.