-module(solution).
-export([open_water/1]).

open_water(Edges) ->
    N = length(Edges),
    Taps = lists:seq(0, N-1),
    StartEnd = lists:map(fun(I) -> {I - element(I+1, Edges), I + element(I+1, Edges)} end, Taps),
    Sorted = lists:sort(StartEnd),
    open_water(Sorted, 0, 0, 0).

open_water([], _, _, Count) -> Count;
open_water([{Start, End} | Rest], CurrentEnd, NextEnd, Count) ->
    if
        Start > CurrentEnd -> -1;
        true ->
            NewNextEnd = max(NextEnd, End),
            if
                NewNextEnd >= N-1 -> Count + 1;
                true ->
                    open_water(Rest, CurrentEnd, NewNextEnd, Count)
            end
    end.

element(Index, List) ->
    lists:nth(Index, List).