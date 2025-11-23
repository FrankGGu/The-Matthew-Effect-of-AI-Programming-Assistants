-module(solution).
-export([reachNumber/1]).

reachNumber(Target) ->
    AbsTarget = abs(Target),
    find_n(1, 0, AbsTarget).

find_n(N, CurrentSum, Target) ->
    NewSum = CurrentSum + N,
    if
        NewSum >= Target ->
            Diff = NewSum - Target,
            if
                Diff rem 2 == 0 ->
                    N;
                true ->
                    find_n(N + 1, NewSum, Target)
            end;
        true ->
            find_n(N + 1, NewSum, Target)
    end.