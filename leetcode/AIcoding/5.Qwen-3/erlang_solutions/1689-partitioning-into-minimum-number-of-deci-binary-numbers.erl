-module(min_deci_binary_numbers).
-export([num_of_decibinary_numbers/1]).

num_of_decibinary_numbers(S) ->
    lists:foldl(fun(Char, Acc) -> max(lists:sum([Char - $0]), Acc) end, 0, S).