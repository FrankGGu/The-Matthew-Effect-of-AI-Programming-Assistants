-module(solution).
-export([max_length/1]).

max_length(Strings) ->
    max_length(Strings, []).

max_length([], Acc) ->
    length(Acc);
max_length([S | Rest], Acc) ->
    case is_unique(S, Acc) of
        true ->
            Max1 = max_length(Rest, lists:append(Acc, S)),
            Max2 = max_length(Rest, Acc),
            max(Max1, Max2);
        false ->
            max_length(Rest, Acc)
    end.

is_unique([], _) ->
    true;
is_unique([C | Rest], Acc) ->
    case lists:member(C, Acc) of
        true -> false;
        false -> is_unique(Rest, [C | Acc])
    end.