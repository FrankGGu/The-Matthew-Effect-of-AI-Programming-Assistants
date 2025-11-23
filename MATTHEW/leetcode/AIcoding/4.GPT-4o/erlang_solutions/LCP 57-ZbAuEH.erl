-module(mole_game).
-export([play/2]).

play(Hits, Time) ->
    max_holes(Hits, Time, 0).

max_holes(0, _, Score) -> Score;
max_holes(Hits, Time, Score) ->
    NewScore = Score + Hits * Time,
    max_holes(Hits - 1, Time - 1, NewScore).