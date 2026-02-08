-module(minimize_string_length).
-export([minimized_string/1]).

minimized_string(S) ->
    minimized_string(S, []).

minimized_string([], Acc) ->
    length(Acc);
minimized_string([C | T], Acc) ->
    case lists:member(C, Acc) of
        true -> minimized_string(T, Acc);
        false -> minimized_string(T, [C | Acc])
    end.