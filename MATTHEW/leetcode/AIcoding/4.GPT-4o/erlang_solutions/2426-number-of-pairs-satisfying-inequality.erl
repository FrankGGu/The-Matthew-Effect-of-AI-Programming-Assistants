-module(solution).
-export([count_pairs/3]).

count_pairs(A, B, k) ->
    SortedA = lists:sort(A),
    SortedB = lists:sort(B),
    count_pairs_helper(SortedA, SortedB, k, 0).

count_pairs_helper([], _, _, Count) -> Count;
count_pairs_helper(_, [], _, Count) -> Count;
count_pairs_helper([H | T], SortedB, k, Count) ->
    NewCount = count_less_than(SortedB, H + k),
    count_pairs_helper(T, SortedB, k, Count + NewCount).

count_less_than([], _) -> 0;
count_less_than([H | T], Limit) when H < Limit -> 1 + count_less_than(T, Limit);
count_less_than([_ | T], Limit) -> count_less_than(T, Limit).