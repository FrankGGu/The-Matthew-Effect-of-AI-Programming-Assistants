-module(solution).
-export([mirror_score/1]).

mirror_score(Str) ->
    mirror_score(Str, 0, 0).

mirror_score([], _, Score) ->
    Score;
mirror_score([H|T], Index, Score) ->
    case lists:nth(Index + 1, T, $ ) of
        H ->
            mirror_score(T, Index + 1, Score + 1);
        _ ->
            mirror_score(T, Index + 1, Score)
    end.