-module(solution).
-export([isAlienSorted/2]).

isAlienSorted(Words, Order) ->
    OrderMap = maps:from_list(lists:zip(string:to_list(Order), lists:seq(0, string:length(Order) - 1))),
    Lists = lists:map(fun Word -> lists:map(fun Char -> maps:get(Char, OrderMap) end, string:to_list(Word)) end, Words),
    lists:all(fun({A, B}) -> A =< B end, lists:zip(Lists, tl(Lists))).