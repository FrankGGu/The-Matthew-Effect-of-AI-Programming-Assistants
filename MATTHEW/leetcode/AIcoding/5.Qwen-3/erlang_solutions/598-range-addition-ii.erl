-module(range_addition_ii).
-export([max_count/2]).

max_count(Height, Width) ->
    max_count(Height, Width, 0, 0, 0).

max_count(_Height, _Width, _A, _B, _C) when _A > _Height; _B > _Width -> 0;
max_count(Height, Width, A, B, C) ->
    max_count(Height, Width, A + 1, B, C).

max_count(Height, Width, A, B, C) ->
    max_count(Height, Width, A, B + 1, C).

max_count(Height, Width, A, B, C) ->
    max_count(Height, Width, A, B, C + 1).

max_count(Height, Width, A, B, C) ->
    if
        A < Height, B < Width, C > 0 ->
            max_count(Height, Width, A, B, C - 1);
        true ->
            (A + 1) * (B + 1)
    end.