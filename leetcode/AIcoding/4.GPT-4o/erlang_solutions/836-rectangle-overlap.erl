-module(solution).
-export([is_rectangle_overlap/4]).

is_rectangle_overlap(A, B, C, D) ->
    not (A >= C orelse B >= D orelse C >= A orelse D >= B).