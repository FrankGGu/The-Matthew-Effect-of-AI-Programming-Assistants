-module(solution).
-export([add_minimum_rungs/2]).

add_minimum_rungs(Rungs, Dist) ->
    add_minimum_rungs(Rungs, Dist, 0, 0).

add_minimum_rungs([], _Dist, _CurrentHeight, AddedRungsCount) ->
    AddedRungsCount;
add_minimum_rungs([Rung | Rest], Dist, CurrentHeight, AddedRungsCount) ->
    Gap = Rung - CurrentHeight,
    NewAddedRungsCount = if
        Gap > Dist ->
            AddedRungsCount + ((Gap - 1) div Dist);
        true ->
            AddedRungsCount
    end,
    add_minimum_rungs(Rest, Dist, Rung, NewAddedRungsCount).