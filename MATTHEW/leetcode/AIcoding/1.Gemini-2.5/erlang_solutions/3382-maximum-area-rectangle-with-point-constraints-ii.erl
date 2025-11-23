-module(solution).
-export([solve/2]).

solve(Points, K) ->
    UniqueXs = lists:sort(lists:usort([X || {X, _} <- Points])),

    MaxArea = 0,
    find_max_area_x1(UniqueXs, Points, K, MaxArea).

find_max_area_x1([], _Points, _K, MaxArea) ->
    MaxArea;
find_max_area_x1([X1 | RestXs], Points, K, CurrentMaxArea) ->
    % Iterate X2 from X1 to the end of UniqueXs
    MaxAreaForX1 = find_max_area_x2(X1, UniqueXs, Points, K, CurrentMaxArea),
    find_max_area_x1(RestXs, Points, K, MaxAreaForX1).

find_max_area_x2(_X1, [], _Points, _K, MaxArea) ->
    MaxArea;
find_max_area_x2(X1, [X2 | RestXs], Points, K, CurrentMaxArea) ->
    NewMaxArea =
        if X2 < X1 ->
            % Skip X2 values smaller than X1 (already handled by outer loop structure, but good for safety)
            CurrentMaxArea;
        true ->
            PointsInStrip = [{X, Y} || {X, Y} <- Points, X >= X1, X =< X2],

            AreaWithX1X2 =
                if length(PointsInStrip) < K ->
                    0; % Cannot form a rectangle with K points
                true ->
                    SortedPointsInStrip = lists:sort(fun({_, Y1}, {_, Y2}) -> Y1 =< Y2 end, PointsInStrip),
                    find_max_area_in_strip(X2 - X1, SortedPointsInStrip, K, 0)
                end,
            erlang:max(CurrentMaxArea, AreaWithX1X2)
        end,
    find_max_area_x2(X1, RestXs, Points, K, NewMaxArea).

find_max_area_in_strip(_Width, SortedPointsInStrip, K, CurrentMaxArea) when length(SortedPointsInStrip) < K ->
    CurrentMaxArea;
find_max_area_in_strip(Width, SortedPointsInStrip, K, CurrentMaxArea) ->
    YsInStrip = [Y || {_, Y} <- SortedPointsInStrip],

    % Convert to array for O(1) access during sliding window
    YsArray = array:from_list(YsInStrip),
    LenYs = array:size(YsArray),

    % Slide window: Left pointer from 0 to LenYs - K
    slide_window_array(Width, YsArray, K, 0, LenYs - K, CurrentMaxArea).

slide_window_array(_Width, _YsArray, _K, Left, RightLimit, MaxArea) when Left > RightLimit ->
    MaxArea;
slide_window_array(Width, YsArray, K, Left, RightLimit, CurrentMaxArea) ->
    Y1 = array:get(Left, YsArray),
    Y2 = array:get(Left + K - 1, YsArray), % Right pointer is Left + K - 1

    Area = Width * (Y2 - Y1),
    NewMaxArea = erlang:max(CurrentMaxArea, Area),

    slide_window_array(Width, YsArray, K, Left + 1, RightLimit, NewMaxArea).