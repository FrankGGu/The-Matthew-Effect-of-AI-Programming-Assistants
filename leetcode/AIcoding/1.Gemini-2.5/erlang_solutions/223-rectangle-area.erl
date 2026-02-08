-module(solution).
-export([rectangle_area/8]).

rectangle_area(Ax1, Ay1, Ax2, Ay2, Bx1, By1, Bx2, By2) ->
    Area1 = (Ax2 - Ax1) * (Ay2 - Ay1),
    Area2 = (Bx2 - Bx1) * (By2 - By1),

    OverlapX1 = math:max(Ax1, Bx1),
    OverlapY1 = math:max(Ay1, By1),
    OverlapX2 = math:min(Ax2, Bx2),
    OverlapY2 = math:min(Ay2, By2),

    OverlapWidth = math:max(0, OverlapX2 - OverlapX1),
    OverlapHeight = math:max(0, OverlapY2 - OverlapY1),

    OverlapArea = OverlapWidth * OverlapHeight,

    Area1 + Area2 - OverlapArea.