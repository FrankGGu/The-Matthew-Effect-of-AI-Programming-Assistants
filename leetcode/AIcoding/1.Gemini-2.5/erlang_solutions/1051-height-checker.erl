-module(solution).
-export([heightChecker/1]).

heightChecker(Heights) ->
    Expected = lists:sort(Heights),
    count_mismatches(Heights, Expected, 0).

count_mismatches([], [], Count) ->
    Count;
count_mismatches([H | T], [E | ET], Count) when H =:= E ->
    count_mismatches(T, ET, Count);
count_mismatches([_ | T], [_ | ET], Count) ->
    count_mismatches(T, ET, Count + 1).