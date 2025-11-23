-module(solution).
-export([count_alternating_subarrays/1]).

count_alternating_subarrays(List) ->
    count_alternating_subarrays(List, 0, 0, 0).

count_alternating_subarrays([], _, Count, Acc) ->
    Acc;
count_alternating_subarrays([_], _, Count, Acc) ->
    Acc;
count_alternating_subarrays([H, H1 | T], Last, Count, Acc) when H =:= Last + 1 orelse H =:= Last - 1 ->
    count_alternating_subarrays([H1 | T], H, Count + 1, Acc + Count + 1);
count_alternating_subarrays([H | T], Last, Count, Acc) ->
    count_alternating_subarrays(T, H, 1, Acc + Count).