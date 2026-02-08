-module(solution).
-export([maximize_greatness/1]).

maximize_greatness(Nums) ->
    SortedNums = lists:sort(Nums),
    greatness_helper(SortedNums, SortedNums, 0).

greatness_helper([], _L2, Count) ->
    Count;
greatness_helper(_L1, [], Count) ->
    Count;
greatness_helper([H1 | T1], [H2 | T2], Count) when H1 < H2 ->
    greatness_helper(T1, T2, Count + 1);
greatness_helper(L1, [_H2 | T2], Count) ->
    greatness_helper(L1, T2, Count).