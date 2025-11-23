-module(solution).
-export([max_matching/2]).

max_matching(Players, Trainers) ->
    PlayersSorted = lists:sort(Players),
    TrainersSorted = lists:sort(Trainers),
    max_match(PlayersSorted, TrainersSorted, 0, 0).

max_match(_, [], Count, _) ->
    Count;
max_match([], _, Count, _) ->
    Count;
max_match(Players, [HTrainer | TTrainer], Count, PlayerIndex) ->
    case lists:drop(PlayerIndex, Players) of
        [] -> Count;
        [HPlayer | _] when HPlayer =< HTrainer ->
            max_match(Players, TTrainer, Count + 1, PlayerIndex + 1);
        [_ | RestPlayers] ->
            max_match(Players, [HTrainer | TTrainer], Count, PlayerIndex + 1)
    end.