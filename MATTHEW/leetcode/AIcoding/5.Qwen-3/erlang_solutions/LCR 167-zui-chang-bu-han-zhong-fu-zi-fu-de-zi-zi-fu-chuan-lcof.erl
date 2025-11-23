-module(solution).
-export([dissolve/1]).

dissolve(Chars) ->
    dissolve(Chars, []).

dissolve([], Acc) ->
    lists:reverse(Acc);
dissolve([H|T], Acc) ->
    case is_upper(H) of
        true ->
            dissolve(T, [H | Acc]);
        false ->
            dissolve(T, Acc)
    end.

is_upper(Char) ->
    Char >= $A andalso Char =< $Z.