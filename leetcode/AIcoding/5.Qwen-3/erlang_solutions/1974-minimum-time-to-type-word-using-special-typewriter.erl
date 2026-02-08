-module(minimum_time_to_type_word).
-export([main/0]).

main() ->
    Input = io:get_line(""),
    Word = string:trim(Input),
    io:format("~p~n", [minimum_time_to_type_word(Word)]).

minimum_time_to_type_word(Word) ->
    InitialPos = 0,
    lists:foldl(fun(Char, Acc) -> Acc + distance(Char, Acc) end, InitialPos, Word).

distance(Char, Pos) ->
    CurrentChar = lists:nth(Pos + 1, "abcdefghijklmnopqrstuvwxyz"),
    CharIndex = char_to_index(Char),
    CurrentIndex = char_to_index(CurrentChar),
    abs(CharIndex - CurrentIndex).

char_to_index(Char) ->
    CharCode = erlang:hd(Char),
    CharCode - $a.