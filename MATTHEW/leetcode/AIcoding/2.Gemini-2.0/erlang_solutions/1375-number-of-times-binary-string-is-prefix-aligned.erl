-module(solution).
-export([num_times_all_blue/1]).

num_times_all_blue(Flips) ->
    num_times_all_blue(Flips, 0, 0, 0).

num_times_all_blue([], MaxSoFar, Count, Index) ->
    Count;
num_times_all_blue([Flip | Rest], MaxSoFar, Count, Index) ->
    NewMaxSoFar = max(MaxSoFar, Flip),
    NewCount = case NewMaxSoFar =:= Index + 1 of
        true -> Count + 1;
        false -> Count
    end,
    num_times_all_blue(Rest, NewMaxSoFar, NewCount, Index + 1).