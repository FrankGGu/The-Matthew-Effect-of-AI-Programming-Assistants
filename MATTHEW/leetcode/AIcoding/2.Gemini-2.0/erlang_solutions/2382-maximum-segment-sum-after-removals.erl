-module(maximum_segment_sum_after_removals).
-export([maximum_segment_sum/2]).

maximum_segment_sum(Nums, Removals) ->
    maximum_segment_sum(Nums, Removals, 0).

maximum_segment_sum(Nums, Removals, Acc) ->
    case Removals of
        [] ->
            max_segment_sum(Nums, Acc);
        [H|T] ->
            NewNums = lists:nthtail(H, Nums),
            {_, Rest} = lists:split(1, NewNums),
            NewAcc = max(Acc, max_segment_sum(Nums, 0)),
            maximum_segment_sum(Rest, T, NewAcc)
    end.

max_segment_sum(Nums, Acc) ->
    max_segment_sum(Nums, 0, 0, Acc).

max_segment_sum([], _, MaxSoFar, Acc) ->
    max(MaxSoFar, Acc);
max_segment_sum([H|T], CurrentMax, MaxSoFar, Acc) ->
    NewCurrentMax = max(0, CurrentMax + H),
    NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
    max_segment_sum(T, NewCurrentMax, NewMaxSoFar, Acc).