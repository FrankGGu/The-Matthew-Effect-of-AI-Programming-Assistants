-module(solution).
-export([is_rectangle_cover/1]).

is_rectangle_cover(Rectangles) ->
    case Rectangles of
        [] -> false;
        _ ->
            {X1, Y1, X2, Y2, Sum} = lists:foldl(
                fun([A, B, C, D], {MinX, MinY, MaxX, MaxY, Area}) ->
                    NewMinX = min(MinX, A),
                    NewMinY = min(MinY, B),
                    NewMaxX = max(MaxX, C),
                    NewMaxY = max(MaxY, D),
                    NewArea = Area + (C - A) * (D - B),
                    {NewMinX, NewMinY, NewMaxX, NewMaxY, NewArea}
                end,
                {infinity, infinity, -infinity, -infinity, 0},
                Rectangles
            ),
            ExpectedArea = (X2 - X1) * (Y2 - Y1),
            if
                Sum =/= ExpectedArea -> false;
                true ->
                    Corners = lists:foldl(
                        fun([A, B, C, D], Acc) ->
                            lists:foldl(
                                fun({X, Y}, Map) ->
                                    Key = {X, Y},
                                    case maps:get(Key, Map, 0) of
                                        Count -> maps:put(Key, Count + 1, Map)
                                    end
                                end,
                                Acc,
                                [{A, B}, {A, D}, {C, B}, {C, D}]
                            )
                        end,
                        #{},
                        Rectangles
                    ),
                    Filtered = maps:filter(
                        fun(Key, Value) ->
                            (Key =:= {X1, Y1} orelse Key =:= {X1, Y2} orelse Key =:= {X2, Y1} orelse Key =:= {X2, Y2}) andalso Value =/= 1
                            orelse
                            (Key =/= {X1, Y1} andalso Key =/= {X1, Y2} andalso Key =/= {X2, Y1} andalso Key =/= {X2, Y2}) andalso Value =/= 2 andalso Value =/= 4
                        end,
                        Corners
                    ),
                    maps:size(Filtered) =:= 0
            end
    end.