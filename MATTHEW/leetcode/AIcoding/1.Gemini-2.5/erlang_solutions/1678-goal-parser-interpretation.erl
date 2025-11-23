-module(solution).
-export([interpret/1]).

interpret(Command) ->
    list_to_binary(interpret_list(binary_to_list(Command))).

interpret_list([]) ->
    [];
interpret_list([$G | T]) ->
    [$G | interpret_list(T)];
interpret_list([$(, $) | T]) ->
    [$o | interpret_list(T)];
interpret_list([$(, $a, $l, $) | T]) ->
    [$a, $l | interpret_list(T)].