-module(solution).
-export([checkOverlap/7]).

checkOverlap(Radius, X_center, Y_center, X1, Y1, X2, Y2) ->
    Closest_x = max(X1, min(X_center, X2)),
    Closest_y = max(Y1, min(Y_center, Y2)),

    Dx = X_center - Closest_x,
    Dy = Y_center - Closest_y,

    Squared_dist = Dx*Dx + Dy*Dy,

    Squared_radius = Radius*Radius,

    Squared_dist =< Squared_radius.