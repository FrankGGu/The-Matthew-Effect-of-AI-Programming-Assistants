-module(random_point_in_non_overlapping_rectangles).
-export([new/1, pick/1]).

new(Rects) ->
    {Rects, lists:seq(1, length(Rects))}.

pick({Rects, Indices}) ->
    [X1, Y1, X2, Y2] = lists:nth(rand:uniform(length(Indices)), Rects),
    RandX = X1 + rand:uniform(X2 - X1),
    RandY = Y1 + rand:uniform(Y2 - Y1),
    {RandX, RandY}.