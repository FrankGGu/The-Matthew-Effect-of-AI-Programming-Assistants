-module(solution).
-export([minimum_area/1]).

get_bbox_and_area(Ones, RectMinR, RectMinC, RectMaxR, RectMaxC) ->
    FilteredOnes = [{R, C} || {R, C} <- Ones,
                               R >= RectMinR, R =< RectMaxR,
                               C >= RectMinC, C =< RectMaxC],
    case FilteredOnes of
        [] ->
            0;
        _ ->
            MinR = lists:min([R || {R, _} <- FilteredOnes]),
            MaxR = lists:max([R || {R, _} <- FilteredOnes]),
            MinC = lists:min([C || {_, C} <- FilteredOnes]),
            MaxC = lists:max([C || {_, C} <- FilteredOnes]),
            (MaxR - MinR + 1) * (MaxC - MinC + 1)
    end.

minimum_area(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    AllOnes = [{R, C} || R <- 0..Rows-1, C <- 0..Cols-1,
                          element(C + 1, element(R + 1, Grid)) == 1],

    MinTotalArea = infinity,

    MinTotalArea1 = lists:foldl(fun(R1, Acc1) ->
        lists:foldl(fun(R2, Acc2) ->
            Area1 = get_bbox_and_area(AllOnes, 0, 0, R1, Cols-1),
            Area2 = get_bbox_and_area(AllOnes, R1+1, 0, R2, Cols-1),
            Area3 = get_bbox_and_area(AllOnes, R2+1, 0, Rows-1, Cols-1),
            min(Acc2, Area1 + Area2 + Area3)
        end, Acc1, R1+1..Rows-2)
    end, MinTotalArea, 0..Rows-3),

    MinTotalArea2 = lists:foldl(fun(C1, Acc1) ->
        lists:foldl(fun(C2, Acc2) ->
            Area1 = get_bbox_and_area(AllOnes, 0, 0, Rows-1, C1),
            Area2 = get_bbox_and_area(AllOnes, 0, C1+1, Rows-1, C2),
            Area3 = get_bbox_and_area(AllOnes, 0, C2+1, Rows-1, Cols-1),
            min(Acc2, Area1 + Area2 + Area3)
        end, Acc1, C1+1..Cols-2)
    end, MinTotalArea, 0..Cols-3),

    MinTotalArea3_1 = lists:foldl(fun(R, AccR) ->
        lists:foldl(fun(C, AccC) ->
            Area1 = get_bbox_and_area(AllOnes, 0, 0, R, C),
            Area2 = get_bbox_and_area(AllOnes, 0, C+1, R, Cols-1),
            Area3 = get_bbox_and_area(AllOnes, R+1, 0, Rows-1, Cols-1),
            min(AccC, Area1 + Area2 + Area3)
        end, AccR, 0..Cols-2)
    end, MinTotalArea, 0..Rows-2),

    MinTotalArea3_2 = lists:foldl(fun(R, AccR) ->
        lists:foldl(fun(C, AccC) ->
            Area1 = get_bbox_and_area(AllOnes, 0, 0, R, Cols-1),
            Area2 = get_bbox_and_area(AllOnes, R+1, 0, Rows-1, C),
            Area3 = get_bbox_and_area(AllOnes, R+1, C+1, Rows-1, Cols-1),
            min(AccC, Area1 + Area2 + Area3)
        end, AccR, 0..Cols-2)
    end, MinTotalArea, 0..Rows-2),

    MinTotalArea4_1 = lists:foldl(fun(C, AccC) ->
        lists:foldl(fun(R, AccR) ->
            Area1 = get_bbox_and_area(AllOnes, 0, 0, R, C),
            Area2 = get_bbox_and_area(AllOnes, R+1, 0, Rows-1, C),
            Area3 = get_bbox_and_area(AllOnes, 0, C+1, Rows-1, Cols-1),
            min(AccR, Area1 + Area2 + Area3)
        end, AccC, 0..Rows-2)
    end, MinTotalArea, 0..Cols-2),

    MinTotalArea4_2 = lists:foldl(fun(C, AccC) ->
        lists:foldl(fun(R, AccR) ->
            Area1 = get_bbox_and_area(AllOnes, 0, 0, Rows-1, C),
            Area2 = get_bbox_and_area(AllOnes, 0, C+1, R, Cols-1),
            Area3 = get_bbox_and_area(AllOnes, R+1, C+1, Rows-1, Cols-1),
            min(AccR, Area1 + Area2 + Area3)
        end, AccC, 0..Rows-2)
    end, MinTotalArea, 0..Cols-2),

    min(MinTotalArea1,
        min(MinTotalArea2,
            min(MinTotalArea3_1,
                min(MinTotalArea3_2,
                    min(MinTotalArea4_1, MinTotalArea4_2)))))).