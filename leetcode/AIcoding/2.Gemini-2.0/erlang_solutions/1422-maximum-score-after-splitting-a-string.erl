-module(maximum_score_after_splitting_a_string).
-export([max_score/1]).

max_score(S) ->
    max_score(S, 0, 0, 0).

max_score([], Ones, Zeros, Max) ->
    Max;
max_score([H|T], Ones, Zeros, Max) ->
    NewZeros = case H of
                   $0 -> Zeros + 1;
                   _ -> Zeros
               end,
    NewOnes = case H of
                   $1 -> Ones + 1;
                   _ -> Ones
               end,
    Len = length(T),
    if Len > 0 ->
        Score = NewZeros + (lists:sum([1 || C <- T, C == $1])),
        NewMax = max(Max, Score),
        max_score(T, NewOnes, NewZeros, NewMax);
    true ->
        Max
    end.