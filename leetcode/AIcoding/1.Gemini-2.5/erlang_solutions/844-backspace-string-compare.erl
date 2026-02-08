-module(solution).
-export([backspaceCompare/2]).

backspaceCompare(S, T) ->
    process_string(S, []) == process_string(T, []).

process_string([], Acc) ->
    lists:reverse(Acc);
process_string([H|T], Acc) when H == $# ->
    case Acc of
        [] ->
            process_string(T, Acc);
        [_|_] ->
            process_string(T, tl(Acc))
    end;
process_string([H|T], Acc) ->
    process_string(T, [H|Acc]).