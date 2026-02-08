-module(solution).
-export([last_remaining/1]).

last_remaining(N) ->
    solve(1, N, 1, true).

solve(Head, Remaining, _Step, _IsLeftToRight) when Remaining == 1 ->
    Head;
solve(Head, Remaining, Step, true) ->
    NewHead = Head + Step,
    NewRemaining = Remaining div 2,
    NewStep = Step * 2,
    solve(NewHead, NewRemaining, NewStep, false);
solve(Head, Remaining, Step, false) ->
    NewHead = if
                  Remaining rem 2 == 1 ->
                      Head + Step;
                  true ->
                      Head
              end,
    NewRemaining = Remaining div 2,
    NewStep = Step * 2,
    solve(NewHead, NewRemaining, NewStep, true).