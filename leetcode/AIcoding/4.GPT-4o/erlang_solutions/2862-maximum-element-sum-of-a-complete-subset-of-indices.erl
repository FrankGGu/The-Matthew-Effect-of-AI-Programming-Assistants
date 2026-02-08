-module(solution).
-export([max_element_sum/1]).

max_element_sum(Indices) ->
    MaxSum = lists:foldl(fun({Index, Value}, Acc) ->
        Acc + Value
    end, 0, lists:zip(Indices, lists:duplicate(length(Indices), 1))),
    MaxSum.