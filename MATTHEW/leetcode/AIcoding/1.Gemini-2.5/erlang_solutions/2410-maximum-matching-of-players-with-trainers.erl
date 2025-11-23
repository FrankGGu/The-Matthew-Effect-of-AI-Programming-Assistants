-module(solution).
-export([max_matching/2]).

max_matching(Players, Trainers) ->
    SortedPlayers = lists:sort(Players),
    SortedTrainers = lists:sort(Trainers),
    match_greedy(SortedPlayers, SortedTrainers, 0).

match_greedy([], _Trainers, Count) -> Count;
match_greedy(_Players, [], Count) -> Count;
match_greedy([PlayerHead | PlayerTail], [TrainerHead | TrainerTail], Count) ->
    if
        PlayerHead =< TrainerHead ->
            match_greedy(PlayerTail, TrainerTail, Count + 1);
        true ->
            match_greedy([PlayerHead | PlayerTail], TrainerTail, Count)
    end.