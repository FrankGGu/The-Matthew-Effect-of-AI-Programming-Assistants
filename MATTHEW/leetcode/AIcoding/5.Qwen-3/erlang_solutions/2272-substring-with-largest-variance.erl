-module(solution).
-export([max_variance/1]).

max_variance(S) ->
    max_variance(S, 0, 0, 0, 0).

max_variance([], _MaxVariance, _CountA, _CountB, _MaxA) -> 
    case _CountA of
        0 -> 0;
        _ -> _MaxVariance
    end;

max_variance([C | T], MaxVariance, CountA, CountB, MaxA) ->
    A = C,
    if
        A == $a ->
            NewCountA = CountA + 1,
            NewCountB = CountB,
            NewMaxA = max(MaxA, NewCountA),
            Var = NewCountA - NewCountB,
            NewMaxVariance = max(MaxVariance, Var),
            max_variance(T, NewMaxVariance, NewCountA, NewCountB, NewMaxA);
        true ->
            NewCountB = CountB + 1,
            NewCountA = CountA,
            Var = NewCountA - NewCountB,
            NewMaxVariance = max(MaxVariance, Var),
            max_variance(T, NewMaxVariance, NewCountA, NewCountB, MaxA)
    end.