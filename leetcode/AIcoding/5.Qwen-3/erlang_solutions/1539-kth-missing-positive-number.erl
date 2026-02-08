-module(kth_missing_positive).
-export([find_kth_missing/2]).

find_kth_missing(Numbers, K) ->
    find_kth_missing(Numbers, K, 1).

find_kth_missing([], K, _) ->
    K;
find_kth_missing([H | T], K, Current) ->
    if
        H == Current ->
            find_kth_missing(T, K, Current + 1);
        true ->
            if
                K == 1 ->
                    Current;
                true ->
                    find_kth_missing([H | T], K - 1, Current + 1)
            end
    end.