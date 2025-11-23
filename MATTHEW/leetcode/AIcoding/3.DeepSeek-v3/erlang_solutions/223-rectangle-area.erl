-spec compute_area(Ax1 :: integer(), Ay1 :: integer(), Ax2 :: integer(), Ay2 :: integer(), Bx1 :: integer(), By1 :: integer(), Bx2 :: integer(), By2 :: integer()) -> integer().
compute_area(Ax1, Ay1, Ax2, Ay2, Bx1, By1, Bx2, By2) ->
    AreaA = (Ax2 - Ax1) * (Ay2 - Ay1),
    AreaB = (Bx2 - Bx1) * (By2 - By1),
    OverlapX = max(0, min(Ax2, Bx2) - max(Ax1, Bx1)),
    OverlapY = max(0, min(Ay2, By2) - max(Ay1, By1)),
    AreaA + AreaB - OverlapX * OverlapY.