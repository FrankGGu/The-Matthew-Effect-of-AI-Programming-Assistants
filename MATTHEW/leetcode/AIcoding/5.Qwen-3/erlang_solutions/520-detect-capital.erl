-module(detect_capital).
-export([detect_capital/1]).

detect_capital(Word) ->
    is_all_lower(Word) orelse (is_first_upper(Word) andalso is_rest_lower(Word)).

is_all_lower([]) -> true;
is_all_lower([H|T]) -> 
    case H >= $a andalso H =< $z of
        true -> is_all_lower(T);
        _ -> false
    end.

is_first_upper([]) -> true;
is_first_upper([H|T]) -> 
    case H >= $A andalso H =< $Z of
        true -> is_rest_lower(T);
        _ -> false
    end.

is_rest_lower([]) -> true;
is_rest_lower([H|T]) -> 
    case H >= $a andalso H =< $z of
        true -> is_rest_lower(T);
        _ -> false
    end.