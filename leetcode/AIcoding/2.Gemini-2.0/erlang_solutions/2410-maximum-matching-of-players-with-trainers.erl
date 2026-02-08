-module(maximum_matching).
-export([max_matching/2]).

max_matching(Players, Trainers) ->
  SortedPlayers = lists:sort(Players),
  SortedTrainers = lists:sort(Trainers),
  max_matching_helper(SortedPlayers, SortedTrainers, 0).

max_matching_helper([], _, Count) ->
  Count;
max_matching_helper(_, [], Count) ->
  Count;
max_matching_helper([Player | RestPlayers], [Trainer | RestTrainers], Count) ->
  if
    Player =< Trainer ->
      max_matching_helper(RestPlayers, RestTrainers, Count + 1);
    true ->
      max_matching_helper([Player | RestPlayers], RestTrainers, Count)
  end.