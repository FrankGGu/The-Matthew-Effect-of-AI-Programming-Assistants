-module(apply_operations_to_make_string_empty).
-export([last_non_empty_string/1]).

last_non_empty_string(S) ->
    last_non_empty_string(S, []).

last_non_empty_string([], Acc) ->
    lists:reverse(Acc);
last_non_empty_string([H|T], Acc) ->
    case lists:member(H, T) of
        true ->
            last_non_empty_string(T, Acc);
        false ->
            last_non_empty_string(T, [H|Acc])
    end.