-module(score_of_a_string).
-export([score_of_string/1]).

score_of_string(S) ->
    score_of_string(S, 0, 0).

score_of_string([], _, Acc) ->
    Acc;
score_of_string([_], _, Acc) ->
    Acc;
score_of_string([C1, C2 | Rest], Index, Acc) ->
    Diff = abs(C1 - C2),
    score_of_string([C2 | Rest], Index + 1, Acc + Diff).