-module(solution).
-export([count_special_chars/1]).

count_special_chars(S) ->
    count_chars(S, 0).

count_chars([], Count) -> Count;
count_chars([H | T], Count) ->
    case is_special_char(H) of
        true -> count_chars(T, Count + 1);
        false -> count_chars(T, Count)
    end.

is_special_char(Char) ->
    Char >= $! andalso Char =< $/ or
    Char >= $: andalso Char =< $@.