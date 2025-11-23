-module(solution).
-export([max_two_events/1]).

max_two_events(Events) ->
    SortedEvents = lists:sort(fun([S1, E1, V1], [S2, E2, V2]) ->
        if
            S1 =:= S2 -> E1 =< E2;
            true -> S1 =< S2
        end
    end, Events),
    {MaxTwo, _} = find_max_two(SortedEvents, [], -1, -1),
    MaxTwo.

find_max_two([], _, MaxSingle, MaxTwo) ->
    {max(MaxTwo, MaxSingle), MaxSingle};
find_max_two([[S, E, V] | Rest], PrevEvents, MaxSingle, MaxTwo) ->
    NewMaxSingle = max(MaxSingle, V),
    NewMaxTwo = case find_max_non_overlapping(PrevEvents, S) of
        -1 -> MaxTwo;
        Val -> max(MaxTwo, Val + V)
    end,
    find_max_two(Rest, [[E, V] | PrevEvents], NewMaxSingle, NewMaxTwo).

find_max_non_overlapping([], _) -> -1;
find_max_non_overlapping([[PrevE, PrevV] | Rest], S) ->
    if
        PrevE < S -> max(PrevV, find_max_non_overlapping(Rest, S));
        true -> find_max_non_overlapping(Rest, S)
    end.