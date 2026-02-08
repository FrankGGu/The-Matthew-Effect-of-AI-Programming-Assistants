-module(solution).
-export([makeBeautiful/2]).

sum_digits(0) -> 0;
sum_digits(N) when N > 0 ->
    (N rem 10) + sum_digits(N div 10).

makeBeautiful(N, Target) ->
    case sum_digits(N) =< Target of
        true -> 0;
        false ->
            makeBeautiful_loop(N, Target, 0, 1)
    end.

makeBeautiful_loop(CurrentN, Target, AddedX, PowerOf10) ->
    case sum_digits(CurrentN) =< Target of
        true ->
            AddedX;
        false ->
            NextMultipleOf = PowerOf10 * 10,
            NPrime = ((CurrentN div NextMultipleOf) + 1) * NextMultipleOf,
            StepX = NPrime - CurrentN,
            makeBeautiful_loop(NPrime, Target, AddedX + StepX, NextMultipleOf)
    end.