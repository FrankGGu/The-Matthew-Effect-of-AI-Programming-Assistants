-module(solution).
-export([minAreaRectII/1]).

minAreaRectII(Points) ->
    N = length(Points),
    if N < 4 ->
        0.0;
    true ->
        PointMap = lists:foldl(fun({X, Y}, Acc) -> maps:put({X, Y}, true, Acc) end, maps:new(), Points),
        PointsArray = array:from_list(Points),

        MinArea = find_min_area(PointsArray, PointMap, N),

        if MinArea == float(1.0/0.0) ->
            0.0;
        true ->
            MinArea
        end
    end.

find_min_area(PointsArray, PointMap, N) ->
    InitialMinArea = float(1.0/0.0),
    find_min_area_loop_i(0, N, PointsArray, PointMap, InitialMinArea).

find_min_area_loop_i(I, N, PointsArray, PointMap, CurrentMinArea) when I < N ->
    P1 = array:get(I, PointsArray),
    NewMinArea = find_min_area_loop_j(I, 0, N, PointsArray, PointMap, CurrentMinArea, P1),
    find_min_area_loop_i(I + 1, N, PointsArray, PointMap, NewMinArea);
find_min_area_loop_i(_I, _N, _PointsArray, _PointMap, CurrentMinArea) ->
    CurrentMinArea.

find_min_area_loop_j(I, J, N, PointsArray, PointMap, CurrentMinArea, P1) when J < N ->
    NewMinArea = 
        if I == J ->
            CurrentMinArea;
        true ->
            P2 = array:get(J, PointsArray),
            find_min_area_loop_k(I, J, 0, N, PointsArray, PointMap, CurrentMinArea, P1, P2)
        end,
    find_min_area_loop_j(I, J + 1, N, PointsArray, PointMap, NewMinArea, P1);
find_min_area_loop_j(_I, _J, _N, _PointsArray, _PointMap, CurrentMinArea, _P1) ->
    CurrentMinArea.

find_min_area_loop_k(I, J, K, N, PointsArray, PointMap, CurrentMinArea, P1, P2) when K < N ->
    NewMinArea = 
        if K == I or K == J ->
            CurrentMinArea;
        true ->
            P3 = array:get(K, PointsArray),
            calculate_area_and_update(P1, P2, P3, PointMap, CurrentMinArea)
        end,
    find_min_area_loop_k(I, J, K + 1, N, PointsArray, PointMap, NewMinArea, P1, P2);
find_min_area_loop_k(_I, _J, _K, _N, _PointsArray, _PointMap, CurrentMinArea, _P1, _P2) ->
    CurrentMinArea.

calculate_area_and_update({X1, Y1}, {X2, Y2}, {X3, Y3}, PointMap, CurrentMinArea) ->
    V1_x = X2 - X1,
    V1_y = Y2 - Y1,

    V2_x = X3 - X2,
    V2_y = Y3 - Y2,

    DotProduct = (V1_x * V2_x) + (V1_y * V2_y),

    if DotProduct == 0 ->
        P4_x = X1 + (X3 - X2),
        P4_y = Y1 + (Y3 - Y2),
        P4 = {P4_x, P4_y},

        if maps:is_key(P4, PointMap) ->
            Side1_sq = V1_x*V1_x + V1_y*V1_y,
            Side2_sq = V2_x*V2_x + V2_y*V2_y,

            Current_area = math:sqrt(float(Side1_sq)) * math:sqrt(float(Side2_sq)),
            math:min(Current_area, CurrentMinArea);
        true ->
            CurrentMinArea
        end;
    true ->
        CurrentMinArea
    end.