-module(validate_stack_sequences).
-export([validate_stack_sequences/2]).

validate_stack_sequences(Pushed, Popped) ->
    validate_stack_sequences(Pushed, Popped, []).

validate_stack_sequences([], [], _) ->
    true;
validate_stack_sequences([], _, _) ->
    false;
validate_stack_sequences([H|T], Popped, Stack) ->
    case Stack of
        [] ->
            validate_stack_sequences(T, Popped, [H]);
        [S|_Stack] when S == hd(Popped) ->
            validate_stack_sequences([H|T], tl(Popped), Stack -- [S]);
        _ ->
            validate_stack_sequences(T, Popped, [H|Stack])
    end.