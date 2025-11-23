-module(rectangle_area).
-export([compute_area/4]).

compute_area(A, B, C, D) ->
    compute_area(A, B, C, D, -10001, -10001, -10001, -10001).

compute_area(A, B, C, D, E, F, G, H) ->
    Area1 = (C - A) * (D - B),
    Area2 = (G - E) * (H - F),
    Left = max(A, E),
    Right = min(C, G),
    Bottom = max(B, F),
    Top = min(D, H),
    OverlapArea = max(Right - Left, 0) * max(Top - Bottom, 0),
    Area1 + Area2 - OverlapArea.