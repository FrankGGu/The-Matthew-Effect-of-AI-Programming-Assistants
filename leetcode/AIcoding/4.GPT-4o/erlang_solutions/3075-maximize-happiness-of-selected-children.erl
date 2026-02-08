-module(solution).
-export([maximize_happiness/2]).

maximize_happiness(H, S) ->
    lists:foldl(fun({Happiness, Count}, Acc) ->
        lists:foldl(fun(_, A) -> A + Happiness end, Acc, lists:seq(1, Count))
    end, 0, H) + lists:nth(1, S).