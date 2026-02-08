-module(mirror_score).
-export([mirror_score/1]).

mirror_score(S) ->
    mirror_score(S, 0).

mirror_score([], Score) ->
    Score;
mirror_score([H|T], Score) ->
    mirror_score(T, Score + score([H|T])).

score(S) ->
    Len = length(S),
    score(S, 0, Len).

score(S, Acc, 0) ->
    Acc;
score(S, Acc, Len) ->
    Sub = lists:sublist(S, 1, Len),
    Rev = lists:reverse(lists:sublist(S, 1, Len)),
    if
        Sub =:= Rev ->
            Len * Len;
        true ->
            score(S, Acc, Len - 1)
    end.