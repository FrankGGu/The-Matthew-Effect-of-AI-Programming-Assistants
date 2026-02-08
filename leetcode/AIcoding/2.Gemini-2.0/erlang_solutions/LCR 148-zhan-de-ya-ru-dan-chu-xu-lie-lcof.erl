-module(validate_stack_sequences).
-export([validate_stack_sequences/2]).

validate_stack_sequences(Pushed, Popped) ->
    validate_stack_sequences(Pushed, Popped, []).

validate_stack_sequences([], [], _) ->
    true;
validate_stack_sequences([], Popped, Stack) ->
    validate_stack_sequences([], Popped, Stack, []);
validate_stack_sequences(Pushed, Popped, Stack) ->
    validate_stack_sequences(Pushed, Popped, Stack, []).

validate_stack_sequences([], [], Stack, Acc) ->
    length(Stack) == 0;
validate_stack_sequences([], Popped, Stack, Acc) ->
    case Popped of
        [H | T] ->
            case Stack of
                [H | Rest] ->
                    validate_stack_sequences([], T, Rest, Acc);
                _ ->
                    false
            end;
        [] ->
            length(Stack) == 0
    end;
validate_stack_sequences(Pushed, Popped, Stack, Acc) ->
    case Pushed of
        [H | T] ->
            validate_stack_sequences(T, Popped, [H | Stack], Acc);
        [] ->
            validate_stack_sequences([], Popped, Stack, Acc)
    end.