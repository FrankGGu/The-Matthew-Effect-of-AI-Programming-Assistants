-module(max_enemy_forts).
-export([maximum_occupied_forts/1]).

maximum_occupied_forts(Forts) ->
    max_occupied_forts(Forts, 0, 0, 0).

max_occupied_forts([], _, Max, _) ->
    Max;
max_occupied_forts([0 | Rest], Count, Max, _Last) ->
    max_occupied_forts(Rest, 0, Max, 0);
max_occupied_forts([1 | Rest], Count, Max, Last) ->
    if
        Last == 0 ->
            max_occupied_forts(Rest, Count + 1, Max, 1);
        true ->
            max_occupied_forts(Rest, 1, Max, 1)
    end;
max_occupied_forts([2 | Rest], Count, Max, Last) ->
    if
        Last == 1 ->
            max_occupied_forts(Rest, 0, max(Max, Count), 2);
        true ->
            max_occupied_forts(Rest, 0, Max, 2)
    end.