-module(maximum_matching_players_with_trainers).
-export([match_players_to_trainers/2]).

match_players_to_trainers(Players, Trainers) ->
    SortedPlayers = lists:sort(Players),
    SortedTrainers = lists:sort(Trainers),
    match(SortedPlayers, SortedTrainers, 0).

match([], _, Count) ->
    Count;
match(_, [], Count) ->
    Count;
match([P | Ps], [T | Ts], Count) when P =< T ->
    match(Ps, Ts, Count + 1);
match([P | Ps], [T | Ts], Count) ->
    match(Ps, [T | Ts], Count).