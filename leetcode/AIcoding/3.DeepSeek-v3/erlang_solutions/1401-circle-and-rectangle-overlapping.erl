-spec check_overlap(Radius :: integer(), X_center :: integer(), Y_center :: integer(), X1 :: integer(), Y1 :: integer(), X2 :: integer(), Y2 :: integer()) -> boolean().
check_overlap(Radius, X_center, Y_center, X1, Y1, X2, Y2) ->
    ClosestX = max(X1, min(X_center, X2)),
    ClosestY = max(Y1, min(Y_center, Y2)),
    DistanceX = X_center - ClosestX,
    DistanceY = Y_center - ClosestY,
    (DistanceX * DistanceX + DistanceY * DistanceY) =< Radius * Radius.