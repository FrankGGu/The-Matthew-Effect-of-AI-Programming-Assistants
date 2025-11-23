-module(elimination_game).
-export([last_remaining/1]).

last_remaining(N) ->
    last_remaining(N, true, 1, 1).

last_remaining(1, _, Start, _) ->
    Start;
last_remaining(N, true, Start, Step) ->
    last_remaining(N div 2, false, Start + Step, Step * 2);
last_remaining(N, false, Start, Step) ->
    if N rem 2 == 0 then
        last_remaining(N div 2, true, Start, Step * 2)
    else
        last_remaining(N div 2, true, Start + Step, Step * 2)
    end.