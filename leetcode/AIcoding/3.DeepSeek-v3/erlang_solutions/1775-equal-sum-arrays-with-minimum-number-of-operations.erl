-module(solution).
-export([min_operations/2]).

min_operations(Nums1, Nums2) ->
    Sum1 = lists:sum(Nums1),
    Sum2 = lists:sum(Nums2),
    if
        Sum1 == Sum2 -> 0;
        Sum1 > Sum2 -> calculate_ops(Nums1, Nums2, Sum1 - Sum2);
        true -> calculate_ops(Nums2, Nums1, Sum2 - Sum1)
    end.

calculate_ops(Larger, Smaller, Diff) ->
    Changes = get_changes(Larger, Smaller),
    SortedChanges = lists:sort(fun(A, B) -> A > B end, Changes),
    count_ops(SortedChanges, Diff, 0).

get_changes(Larger, Smaller) ->
    lists:flatmap(fun(X) -> [X - 1] end, Larger) ++
    lists:flatmap(fun(X) -> [6 - X] end, Smaller).

count_ops([], Remaining, Ops) ->
    if
        Remaining > 0 -> -1;
        true -> Ops
    end;
count_ops([Change | Rest], Remaining, Ops) ->
    if
        Remaining =< 0 -> Ops;
        true ->
            NewRemaining = Remaining - Change,
            count_ops(Rest, NewRemaining, Ops + 1)
    end.