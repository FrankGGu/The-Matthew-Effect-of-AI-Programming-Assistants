-spec match_players_and_trainers(Players :: [integer()], Trainers :: [integer()]) -> integer().
match_players_and_trainers(Players, Trainers) ->
    SortedPlayers = lists:sort(fun(A, B) -> A =< B end, Players),
    SortedTrainers = lists:sort(fun(A, B) -> A =< B end, Trainers),
    match(SortedPlayers, SortedTrainers, 0).

match([P | Players], [T | Trainers], Count) when P =< T ->
    match(Players, Trainers, Count + 1);
match([P | Players], [T | Trainers], Count) when P > T ->
    match([P | Players], Trainers, Count);
match(_, _, Count) ->
    Count.