-module(solution).
-export([find_kth_missing/2]).

find_kth_missing(Numbers, K) ->
    find_kth_missing_helper(Numbers, K, 1, 0).

find_kth_missing_helper([], 0, _, Count) -> Count;
find_kth_missing_helper([], K, Current, Count) -> find_kth_missing_helper([], K - 1, Current + 1, Count);
find_kth_missing_helper([H|T], K, Current, Count) when H == Current ->
    find_kth_missing_helper(T, K, Current + 1, Count);
find_kth_missing_helper([H|T], K, Current, Count) when H > Current ->
    find_kth_missing_helper([H|T], K - 1, Current + 1, Count);
find_kth_missing_helper([H|T], K, Current, Count) ->
    find_kth_missing_helper(T, K, Current + 1, Count).