-module(largest_triangle_area).
-export([largest_triangle_area/1]).

largest_triangle_area(Points) ->
    lists:max([area(P1, P2, P3) || P1 <- Points, P2 <- Points, P3 <- Points, P1 =/= P2, P2 =/= P3, P1 =/= P3]).

area({X1, Y1}, {X2, Y2}, {X3, Y3}) ->
    abs((X2 - X1)*(Y3 - Y1) - (X3 - X1)*(Y2 - Y1)) / 2.