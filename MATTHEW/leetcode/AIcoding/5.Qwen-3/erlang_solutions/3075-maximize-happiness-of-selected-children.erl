-module(maximize_happiness_of_selected_children).
-export([maximize_happiness/2]).

maximize_happiness(Happiness, K) ->
    Sorted = lists:reverse(lists:sort(Happiness)),
    lists:foldl(fun(I, {Acc, Count}) when Count < K -> {Acc + I, Count + 1}; (I, {Acc, Count}) -> {Acc, Count} end, {0, 0}, Sorted).