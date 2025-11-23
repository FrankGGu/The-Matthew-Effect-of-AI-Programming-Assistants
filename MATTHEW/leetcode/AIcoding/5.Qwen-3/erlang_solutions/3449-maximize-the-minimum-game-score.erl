-module(solution).
-export([maximize_min_game_score/1]).

maximize_min_game_score(Scores) ->
    Sorted = lists:sort(Scores),
    N = length(Sorted),
    Left = lists:sublist(Sorted, N div 2),
    Right = lists:sublist(Sorted, N - (N div 2), N div 2),
    lists:last(Left).

maximize_min_game_score() ->
    maximize_min_game_score([]).