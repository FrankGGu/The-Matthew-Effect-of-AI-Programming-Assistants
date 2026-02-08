-module(solution).
-export([interpret/1]).

interpret(Str) ->
    interpret(Str, []).

interpret([], Acc) ->
    lists:reverse(Acc);
interpret([$G,$o,$a,$l | Rest], Acc) ->
    interpret(Rest, [$l | Acc]);
interpret([$G,$o,$l | Rest], Acc) ->
    interpret(Rest, [$l | Acc]);
interpret([$G | Rest], Acc) ->
    interpret(Rest, [$g | Acc]);
interpret([$o | Rest], Acc) ->
    interpret(Rest, [$o | Acc]);
interpret([$a | Rest], Acc) ->
    interpret(Rest, [$a | Acc]);
interpret([$l | Rest], Acc) ->
    interpret(Rest, [$l | Acc]);
interpret([_ | Rest], Acc) ->
    interpret(Rest, Acc).