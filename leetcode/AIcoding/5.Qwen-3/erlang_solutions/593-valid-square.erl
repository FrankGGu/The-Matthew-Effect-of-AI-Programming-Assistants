-module(valid_square).
-export([valid_square/1]).

valid_square([A,B,C,D]) ->
    Points = [A,B,C,D],
    Distances = lists:usort([distance(P1, P2) || P1 <- Points, P2 <- Points, P1 /= P2]),
    length(Distances) == 2 andalso lists:nth(1, Distances) > 0 andalso lists:nth(2, Distances) == 2 * lists:nth(1, Distances).

distance({X1,Y1}, {X2,Y2}) ->
    (X1 - X2)*(X1 - X2) + (Y1 - Y2)*(Y1 - Y2).