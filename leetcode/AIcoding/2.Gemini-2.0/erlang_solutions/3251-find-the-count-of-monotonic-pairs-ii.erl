-module(monotonic_pairs_ii).
-export([count_monotonic_pairs/1]).

count_monotonic_pairs(Nums) ->
    count_monotonic_pairs(Nums, 0, 0, 0).

count_monotonic_pairs([], Acc, _, _) ->
    Acc;
count_monotonic_pairs([H|T], Acc, Inc, Dec) ->
    count_monotonic_pairs(T, Acc + Inc + Dec,
        count_increasing(T, H),
        count_decreasing(T, H)).

count_increasing([], _) ->
    0;
count_increasing([H|T], Prev) ->
    if
        H >= Prev ->
            1 + count_increasing(T, H);
        true ->
            count_increasing(T, Prev)
    end.

count_decreasing([], _) ->
    0;
count_decreasing([H|T], Prev) ->
    if
        H <= Prev ->
            1 + count_decreasing(T, H);
        true ->
            count_decreasing(T, Prev)
    end.