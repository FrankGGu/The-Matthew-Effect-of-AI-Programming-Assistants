-module(solution).
-export([thousand_separator/1]).

thousand_separator(N) ->
    S = integer_to_list(N),
    Len = length(S),
    format_string(S, Len, []).

format_string([], _Remaining, Acc) ->
    lists:reverse(Acc);
format_string([H|T], Remaining, Acc) ->
    NewAcc = [H | Acc],
    NewRemaining = Remaining - 1,
    if
        NewRemaining > 0 andalso (NewRemaining rem 3 == 0) ->
            format_string(T, NewRemaining, ['.' | NewAcc]);
        true ->
            format_string(T, NewRemaining, NewAcc)
    end.