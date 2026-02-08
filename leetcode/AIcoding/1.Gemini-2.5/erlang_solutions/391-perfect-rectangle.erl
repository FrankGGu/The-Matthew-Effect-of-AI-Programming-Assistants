-module(solution).
-export([is_rectangle_cover/1]).

-spec is_rectangle_cover(Rectangles :: [[integer()]]) -> boolean().
is_rectangle_cover(Rectangles) ->
    if
        Rectangles == [] -> false;
        true ->
            [X1, Y1, X2, Y2] = hd(Rectangles),

            InitialPointsMap = #{},
            PointsMap1 = update_point_count(InitialPointsMap, {X1, Y1}),
            PointsMap2 = update_point_count(PointsMap1, {X1, Y2}),
            PointsMap3 = update_point_count(PointsMap2, {X2, Y1}),
            PointsMap4 = update_point_count(PointsMap3, {X2, Y2}),

            InitialAcc = #{
                min_x => X1,
                min_y => Y1,
                max_x => X2,
                max_y => Y2,
                total_area => (X2 - X1) * (Y2 - Y1),
                points => PointsMap4
            },

            FinalState = lists:foldl(
                fun([RX1, RY1, RX2, RY2], Acc) ->
                    MinX = maps:get(min_x, Acc),
                    MinY = maps:get(min_y, Acc),
                    MaxX = maps:get(max_x, Acc),
                    MaxY = maps:get(max_y, Acc),
                    TotalArea = maps:get(total_area, Acc),
                    PointsMap = maps:get(points, Acc),

                    NewMinX = min(MinX, RX1),
                    NewMinY = min(MinY, RY1),
                    NewMaxX = max(MaxX, RX2),
                    NewMaxY = max(MaxY, RY2),
                    NewTotalArea = TotalArea + (RX2 - RX1) * (RY2 - RY1),

                    PointsMapA = update_point_count(PointsMap, {RX1, RY1}),
                    PointsMapB = update_point_count(PointsMapA, {RX1, RY2}),
                    PointsMapC = update_point_count(PointsMapB, {RX2, RY1}),
                    PointsMapD = update_point_count(PointsMapC, {RX2, RY2}),

                    Acc#{
                        min_x => NewMinX,
                        min_y => NewMinY,
                        max_x => NewMaxX,
                        max_y => NewMaxY,
                        total_area => NewTotalArea,
                        points => PointsMapD
                    }
                end,
                InitialAcc,
                tl(Rectangles)
            ),

            MinX = maps:get(min_x, FinalState),
            MinY = maps:get(min_y, FinalState),
            MaxX = maps:get(max_x, FinalState),
            MaxY = maps:get(max_y, FinalState),
            TotalArea = maps:get(total_area, FinalState),
            PointsMap = maps:get(points, FinalState),

            ExpectedArea = (MaxX - MinX) * (MaxY - MinY),
            AreaMatches = (TotalArea == ExpectedArea),

            OverallCorners = [{MinX, MinY}, {MinX, MaxY}, {MaxX, MinY}, {MaxX, MaxY}],

            OddCountPoints = maps:fold(
                fun(Point, Count, Acc) ->
                    if
                        Count rem 2 == 1 -> [Point | Acc];
                        true -> Acc
                    end
                end,
                [],
                PointsMap
            ),

            PointCountMatches = (length(OddCountPoints) == 4) andalso (lists:sort(OddCountPoints) == lists:sort(OverallCorners)),

            AreaMatches andalso PointCountMatches
    end.

update_point_count(PointsMap, Point) ->
    maps:update_with(Point, fun(Count) -> Count + 1 end, 1, PointsMap).