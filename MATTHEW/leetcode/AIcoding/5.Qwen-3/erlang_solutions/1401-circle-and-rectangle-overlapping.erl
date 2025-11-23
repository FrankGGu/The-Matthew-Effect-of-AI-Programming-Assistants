-module(solution).
-export([check_overlap/2]).

check_overlap({X1, Y1, X2, Y2}, {CX, CY, R}) ->
    ClampedX = max(X1, min(CX, X2)),
    ClampedY = max(Y1, min(CY, Y2)),
    DX = CX - ClampedX,
    DY = CY - ClampedY,
    DX * DX + DY * DY < R * R.