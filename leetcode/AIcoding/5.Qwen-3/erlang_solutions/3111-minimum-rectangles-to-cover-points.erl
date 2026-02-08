-module(min_rectangles_to_cover_points).
-export([numberOfRectangles/1]).

numberOfRectangles(Points) ->
    X = lists:foldl(fun({X, _}, Acc) -> [X | Acc] end, [], Points),
    Y = lists:foldl(fun({_, Y}, Acc) -> [Y | Acc] end, [], Points),
    XUnique = lists:usort(X),
    YUnique = lists:usort(Y),
    length(XUnique) * length(YUnique).