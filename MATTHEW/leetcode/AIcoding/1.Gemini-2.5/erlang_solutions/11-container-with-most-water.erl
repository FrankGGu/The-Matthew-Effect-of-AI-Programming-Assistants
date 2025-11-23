-module(solution).
-export([max_area/1]).

max_area(HeightList) ->
    HeightArray = array:from_list(HeightList),
    N = array:size(HeightArray),
    max_area_recursive(HeightArray, 0, N - 1, 0).

max_area_recursive(HeightArray, Left, Right, CurrentMax) when Left < Right ->
    H_Left = array:get(Left, HeightArray),
    H_Right = array:get(Right, HeightArray),

    Width = Right - Left,
    MinHeight = min(H_Left, H_Right),
    Area = MinHeight * Width,

    NewMax = max(CurrentMax, Area),

    if
        H_Left < H_Right ->
            max_area_recursive(HeightArray, Left + 1, Right, NewMax);
        true ->
            max_area_recursive(HeightArray, Left, Right - 1, NewMax)
    end;
max_area_recursive(_HeightArray, _Left, _Right, CurrentMax) ->
    CurrentMax.