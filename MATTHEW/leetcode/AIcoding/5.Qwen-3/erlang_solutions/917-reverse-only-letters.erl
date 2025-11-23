-module(reverse_only_letters).
-export([reverse_letters/1]).

reverse_letters(S) ->
    Letters = [C || C <- S, is_letter(C)],
    reverse_letters(S, Letters, []).

reverse_letters([], _, Acc) ->
    lists:reverse(Acc);
reverse_letters([C | T], [L | Ls], Acc) when is_letter(C) ->
    reverse_letters(T, Ls, [L | Acc]);
reverse_letters([C | T], Ls, Acc) ->
    reverse_letters(T, Ls, [C | Acc]).

is_letter(C) ->
    (C >= $a andalso C =< $z) orelse (C >= $A andalso C =< $Z).