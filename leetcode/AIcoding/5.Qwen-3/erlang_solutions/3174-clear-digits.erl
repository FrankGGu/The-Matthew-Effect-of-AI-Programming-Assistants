-module(clear_digits).
-export([clear_digits/1]).

clear_digits(S) ->
    clear_digits(S, []).

clear_digits([], Acc) ->
    lists:reverse(Acc);
clear_digits([H | T], Acc) when H >= $0, H =< $9 ->
    clear_digits(T, [H | Acc]);
clear_digits([_ | T], Acc) ->
    clear_digits(T, Acc).