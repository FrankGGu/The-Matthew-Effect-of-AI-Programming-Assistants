-module(max_consecutive_floors).
-export([max_consecutive_banned/2]).

max_consecutive_banned(Banned, N) ->
    BannedSet = sets:from_list(Banned),
    max_consecutive(BannedSet, N, 0, 0).

max_consecutive(_, 0, Current, Max) ->
    max(Current, Max);
max_consecutive(BannedSet, Floor, Current, Max) ->
    if
        sets:is_element(Floor, BannedSet) ->
            max_consecutive(BannedSet, Floor - 1, 0, max(Current, Max));
        true ->
            max_consecutive(BannedSet, Floor - 1, Current + 1, Max)
    end.