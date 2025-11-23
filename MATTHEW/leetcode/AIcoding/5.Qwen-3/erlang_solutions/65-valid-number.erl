-module(valid_number).
-export([is_valid/1]).

is_valid(S) ->
    is_valid(S, 0, false, false, false).

is_valid([], _, _, _, _) -> true;
is_valid([H|T], State, HasE, HasDot, HasSign) ->
    case State of
        0 ->
            if
                H == $+ orelse H == $- ->
                    is_valid(T, 1, HasE, HasDot, true);
                H == $e orelse H == $E ->
                    false;
                H == $. ->
                    is_valid(T, 2, HasE, true, HasSign);
                H >= $0 andalso H =< $9 ->
                    is_valid(T, 3, HasE, HasDot, HasSign);
                true ->
                    false
            end;
        1 ->
            if
                H == $. ->
                    is_valid(T, 2, HasE, true, true);
                H >= $0 andalso H =< $9 ->
                    is_valid(T, 3, HasE, HasDot, true);
                true ->
                    false
            end;
        2 ->
            if
                H == $e orelse H == $E ->
                    is_valid(T, 4, true, HasDot, HasSign);
                H >= $0 andalso H =< $9 ->
                    is_valid(T, 3, HasE, HasDot, HasSign);
                true ->
                    false
            end;
        3 ->
            if
                H == $e orelse H == $E ->
                    is_valid(T, 4, true, HasDot, HasSign);
                H >= $0 andalso H =< $9 ->
                    is_valid(T, 3, HasE, HasDot, HasSign);
                true ->
                    false
            end;
        4 ->
            if
                H == $+ orelse H == $- ->
                    is_valid(T, 5, true, HasDot, HasSign);
                H >= $0 andalso H =< $9 ->
                    is_valid(T, 6, true, HasDot, HasSign);
                true ->
                    false
            end;
        5 ->
            if
                H >= $0 andalso H =< $9 ->
                    is_valid(T, 6, true, HasDot, HasSign);
                true ->
                    false
            end;
        6 ->
            if
                H >= $0 andalso H =< $9 ->
                    is_valid(T, 6, true, HasDot, HasSign);
                true ->
                    false
            end
    end.