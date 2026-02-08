-module(solution).
-export([largest_square_area/4]).

largest_square_area(X1, Y1, X2, Y2) ->
    MaxSide = min(X2 - X1, Y2 - Y1),
    MaxSide * MaxSide.