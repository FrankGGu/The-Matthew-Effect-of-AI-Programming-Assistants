-module(elimination_game).
-export([play/1]).

play(N) ->
    play(N, 1, 1, true).

play(1, _, _, _) ->
    1;
play(N, Step, Start, Direction) ->
    if
        N == 1 ->
            Start;
        true ->
            Remaining = N - (N rem 2),
            NewStart = if
                Direction ->
                    Start + Step;
                true ->
                    Start + Step * (N - (N rem 2)) - Step
            end,
            play(Remaining div 2, Step * 2, NewStart, not Direction)
    end.