-module(cyclically_rotating_a_grid).
-export([rotate_grid/2]).

rotate_grid(Grid, k) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Total = Rows * Cols,
    Rotations = k rem Total,
    if
        Rotations == 0 -> Grid;
        true -> rotate(Grid, Rotations, Rows, Cols)
    end.

rotate(Grid, K, R, C) ->
    Elements = flatten(Grid),
    NewElements = lists:sublist(Elements, Total - K) ++ lists:sublist(Elements, K),
    reshape(NewElements, R, C).

flatten([]) -> [];
flatten([H | T]) -> H ++ flatten(T).

reshape([], _, _) -> [];
reshape(Elements, R, C) ->
    [lists:subseq(Elements, 1, C) | reshape(lists:nthtail(C, Elements), R, C)].

Total = R * C.