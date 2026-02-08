-module(solution).
-export([min_array_sum/1]).

min_array_sum(Nums) ->
    SortedNums = lists:sort(Nums),
    calculate_score(SortedNums, 0).

calculate_score([], Acc) ->
    Acc;
calculate_score([H1, H2 | T], Acc) ->
    Diff = abs(H1 - H2),
    calculate_score(T, Acc + Diff).