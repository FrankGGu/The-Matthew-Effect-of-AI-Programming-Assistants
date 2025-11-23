-module(max_area).
-export([max_area/4]).

max_area(H, V, M, N) ->
    H1 = lists:sort(H),
    V1 = lists:sort(V),
    MaxH = max_gap(H1, M),
    MaxV = max_gap(V1, N),
    MaxH * MaxV.

max_gap([], _) -> 0;
max_gap([H | T], Max) ->
    case T of
        [] -> max(H, Max - H);
        _ -> max(max(H - 0, Max - H), max_gap(T, Max))
    end.