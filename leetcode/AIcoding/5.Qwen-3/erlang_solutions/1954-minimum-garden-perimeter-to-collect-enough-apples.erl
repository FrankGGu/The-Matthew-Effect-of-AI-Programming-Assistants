-module(min_garden_perimeter).
-export([gardenPerimeter/1]).

gardenPerimeter(Apples) ->
    N = 1,
    gardenPerimeter(Apples, N, 0).

gardenPerimeter(Apples, N, Acc) ->
    Perimeter = 8 * N,
    Area = (N + 1) * (N + 1),
    if
        Acc + Area >= Apples -> Perimeter;
        true -> gardenPerimeter(Apples, N + 1, Acc + Area)
    end.