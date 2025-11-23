-module(goal_parser).
-export([interpret/1]).

interpret(Command) ->
  interpret(Command, []).

interpret([], Acc) ->
  lists:reverse(Acc);
interpret([$G | Rest], Acc) ->
  interpret(Rest, [$G | Acc]);
interpret([$() | Rest], Acc) ->
  case Rest of
    [$) | Tail] ->
      interpret(Tail, [$o | Acc]);
    _ ->
      Acc
  end;
interpret([$(, $a, l, $, ) | Rest], Acc) ->
  interpret(Rest, [$a, $l | Acc]).