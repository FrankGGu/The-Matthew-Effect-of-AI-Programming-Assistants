-module(cut_bamboo).
-export([min_cuts/1]).

min_cuts(Heights) ->
    min_cuts(Heights, 0).

min_cuts([], Acc) ->
    Acc;
min_cuts(Heights, Acc) ->
    Max = lists:max(Heights),
    if
        Max == 1 ->
            Acc;
        true ->
            NewHeights = [ceiling(H / 2) || H <- Heights],
            min_cuts(NewHeights, Acc + 1)
    end.

ceiling(X) ->
    trunc(X + 0.999999999).