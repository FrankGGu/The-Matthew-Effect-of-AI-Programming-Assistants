-module(minimum_string_length).
-export([min_length/1]).

min_length(S) ->
    Stack = [],
    min_length_helper(S, Stack).

min_length_helper([], Stack) ->
    length(Stack);
min_length_helper([H|T], Stack) ->
    case Stack of
        [Top | Rest] ->
            case {Top, H} of
                {<<"a">>, <<"b">>} ->
                    min_length_helper(T, Rest);
                {<<"c">>, <<"d">>} ->
                    min_length_helper(T, Rest);
                _ ->
                    min_length_helper(T, [H | Stack])
            end;
        [] ->
            min_length_helper(T, [H])
    end.