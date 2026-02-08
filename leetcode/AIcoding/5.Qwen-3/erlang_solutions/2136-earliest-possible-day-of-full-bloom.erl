-module(earliest_possible_day_of_full_bloom).
-export([earlyBloom/2]).

earlyBloom(Paths, Buds) ->
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A < B end, lists:zip(Paths, Buds)),
    Time = lists:foldl(fun({P, B}, Acc) ->
        MaxTime = max(Acc + P, Acc + B),
        MaxTime
    end, 0, Sorted),
    Time.