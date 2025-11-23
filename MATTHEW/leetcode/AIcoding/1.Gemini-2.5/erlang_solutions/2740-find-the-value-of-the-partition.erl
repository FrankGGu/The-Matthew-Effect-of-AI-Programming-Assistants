-module(solution).
-export([find_value_of_partition/1]).

find_value_of_partition(Nums) ->
    SortedNums = lists:sort(Nums),
    find_min_diff(SortedNums).

find_min_diff([_]) ->
    0;
find_min_diff([H1, H2 | T]) ->
    Diffs = calculate_all_diffs([H1, H2 | T], []),
    lists:min(Diffs).

calculate_all_diffs([_], Acc) ->
    Acc;
calculate_all_diffs([H1, H2 | T], Acc) ->
    calculate_all_diffs([H2 | T], [abs(H2 - H1) | Acc]).