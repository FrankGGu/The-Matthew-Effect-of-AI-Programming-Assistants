-module(replace_all_digits_with_characters).
-export([replaceDigits/1]).

replaceDigits(S) ->
    replaceDigits(S, 0, []).

replaceDigits([], _, Acc) ->
    lists:reverse(Acc);
replaceDigits([D | T], I, Acc) when D >= $0, D =< $9 ->
    Char = integer_to_list(D - $0 + 1 + I),
    replaceDigits(T, I + 1, [lists:nth(1, Char) | Acc]);
replaceDigits([C | T], I, Acc) ->
    replaceDigits(T, I, [C | Acc]).