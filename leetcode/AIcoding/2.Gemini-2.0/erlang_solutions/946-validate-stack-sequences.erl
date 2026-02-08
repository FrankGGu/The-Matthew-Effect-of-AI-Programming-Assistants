-module(validate_stack_sequences).
-export([validate_stack_sequences/2]).

validate_stack_sequences(Pushed, Popped) ->
  validate_stack_sequences(Pushed, Popped, []).

validate_stack_sequences([], [], _) ->
  true;
validate_stack_sequences([], Popped, Stack) ->
  validate_popped(Popped, Stack);
validate_stack_sequences(Pushed, Popped, Stack) ->
  [H | T] = Pushed,
  case Popped of
    [H | Rest] ->
      validate_stack_sequences(T, Rest, Stack);
    _ ->
      validate_stack_sequences(T, Popped, [H | Stack])
  end.

validate_popped([], []) ->
  true;
validate_popped(Popped, []) ->
  false;
validate_popped([H | Rest], [H | StackRest]) ->
  validate_popped(Rest, StackRest);
validate_popped(_, _) ->
  false.