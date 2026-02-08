-module(solution).
-export([max_diff_even_odd_frequency/1]).

max_diff_even_odd_frequency(Nums) ->
    Vals = [if X rem 2 == 0 -> 1; true -> -1 end || X <- Nums],

    MaxSum = kadane(Vals),

    NegVals = [-X || X <- Vals],
    MinSum = -kadane(NegVals),

    max(abs(MaxSum), abs(MinSum)).

kadane(List) ->
    case List of
        [] -> 0;
        [H|T] ->
            kadane_loop(T, H, H)
    end.

kadane_loop([], _CurrentMax, MaxSoFar) ->
    MaxSoFar;
kadane_loop([H|T], CurrentMax, MaxSoFar) ->
    NewCurrentMax = max(H, CurrentMax + H),
    NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
    kadane_loop(T, NewCurrentMax, NewMaxSoFar).