-module(solution).
-export([largest_area_of_square_inside_two_rectangles/1]).

largest_area_of_square_inside_two_rectangles([Rec1_x1, Rec1_y1, Rec1_x2, Rec1_y2, Rec2_x1, Rec2_y1, Rec2_x2, Rec2_y2]) ->
    Intersect_x1 = erlang:max(Rec1_x1, Rec2_x1),
    Intersect_y1 = erlang:max(Rec1_y1, Rec2_y1),
    Intersect_x2 = erlang:min(Rec1_x2, Rec2_x2),
    Intersect_y2 = erlang:min(Rec1_y2, Rec2_y2),

    Width = Intersect_x2 - Intersect_x1,
    Height = Intersect_y2 - Intersect_y1,

    if
        Width <= 0 orelse Height <= 0 ->
            0;
        true ->
            Side = erlang:min(Width, Height),
            Side * Side
    end.