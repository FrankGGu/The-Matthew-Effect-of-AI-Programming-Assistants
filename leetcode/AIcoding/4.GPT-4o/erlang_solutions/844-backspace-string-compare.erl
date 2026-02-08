-module(solution).
-export([backspace_compare/2]).

backspace_compare(S, T) ->
    string_to_list(S1) = process_string(S),
    string_to_list(T1) = process_string(T),
    S1 =:= T1.

process_string(Str) ->
    process_string(Str, []).

process_string([], Acc) ->
    lists:reverse(Acc);
process_string([$# | Rest], Acc) ->
    process_string(Rest, tl(Acc));
process_string([C | Rest], Acc) ->
    process_string(Rest, [C | Acc]).