-module(solution).
-export([countBinarySubstrings/1]).

countBinarySubstrings(S) ->
    Counts = group_counts(S),
    sum_min_adjacent(Counts).

group_counts([]) ->
    [];
group_counts([H|T]) ->
    group_counts_acc(T, H, 1, []).

group_counts_acc([], _PrevChar, Count, Acc) ->
    lists:reverse([Count|Acc]);
group_counts_acc([H|T], PrevChar, Count, Acc) when H == PrevChar ->
    group_counts_acc(T, PrevChar, Count+1, Acc);
group_counts_acc([H|T], PrevChar, Count, Acc) when H /= PrevChar ->
    group_counts_acc(T, H, 1, [Count|Acc]).

sum_min_adjacent([]) ->
    0;
sum_min_adjacent([_]) ->
    0;
sum_min_adjacent([A, B | T]) ->
    min(A, B) + sum_min_adjacent([B | T]).