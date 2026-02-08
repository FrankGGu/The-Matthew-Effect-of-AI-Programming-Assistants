-module(solution).
-export([min_boxes/2]).

min_boxes(N, a) when N > 0 ->
    min_boxes(N, a, 0).

min_boxes(0, _, Boxes) -> 
    Boxes;
min_boxes(N, A, Boxes) ->
    min_boxes(N - 1, lists:sort(A), Boxes + 1).