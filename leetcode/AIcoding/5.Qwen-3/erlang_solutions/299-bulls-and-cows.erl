-module(bulls_and_cows).
-export([get_hint/2]).

get_hint(Seed, Guess) ->
    Bulls = count_bulls(Seed, Guess),
    Cows = count_cows(Seed, Guess, Bulls),
    lists:flatten(io_lib:format("~B bulls and ~B cows", [Bulls, Cows])).

count_bulls([], []) -> 0;
count_bulls([H|T], [H|T2]) -> 1 + count_bulls(T, T2);
count_bulls([_|T], [_|T2]) -> count_bulls(T, T2).

count_cows(Seed, Guess, Bulls) ->
    SeedMap = count_chars(Seed),
    GuessMap = count_chars(Guess),
    Total = maps:fold(fun(Key, Val, Acc) -> Acc + min(Val, maps:get(Key, GuessMap, 0)) end, 0, SeedMap),
    Total - Bulls.

count_chars(Str) ->
    maps:from_list([{Char, count_char(Str, Char)} || Char <- lists:usort(Str)]).

count_char([], _) -> 0;
count_char([C|T], C) -> 1 + count_char(T, C);
count_char([_|T], C) -> count_char(T, C).