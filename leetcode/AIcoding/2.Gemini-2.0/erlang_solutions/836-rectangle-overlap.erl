-module(rectangle_overlap).
-export([is_rectangle_overlap/2]).

is_rectangle_overlap([[x1, y1, x2, y2], [x3, y3, x4, y4]]) ->
    x1 < x4 and x3 < x2 and y1 < y4 and y3 < y2.