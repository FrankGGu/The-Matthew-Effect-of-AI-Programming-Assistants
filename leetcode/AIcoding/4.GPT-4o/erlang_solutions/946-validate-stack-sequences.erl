-module(validate_stack_sequences).
-export([validate_stack_sequences/2]).

validate_stack_sequences(Pushed, Popped) ->
    validate(Pushed, Popped, [], 0).

validate([], [], [], _) -> true;
validate([], _, _, _) -> false;
validate(Pushed, [H|T], Stack, Index) ->
    case Stack of
        [] -> 
            case lists:nth(Index + 1, Pushed) of
                H -> validate(Pushed, T, Stack, Index + 1);
                _ -> false
            end;
        [Top | Rest] ->
            if
                Top =:= H -> validate(Pushed, T, Rest, Index);
                true -> validate(Pushed, [H | T], [lists:nth(Index + 1, Pushed) | Stack], Index + 1)
            end
    end.