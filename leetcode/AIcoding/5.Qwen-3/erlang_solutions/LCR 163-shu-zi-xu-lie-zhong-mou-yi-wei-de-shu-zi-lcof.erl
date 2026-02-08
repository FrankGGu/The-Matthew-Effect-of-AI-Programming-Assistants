-module(solution).
-export([find_kth_number/1]).

find_kth_number(K) ->
    find_kth_number(K, 1, 1).

find_kth_number(K, Start, Digits) ->
    Count = 9 * math:pow(10, Digits - 1),
    if
        K > Count ->
            find_kth_number(K - Count, Start * 10, Digits + 1);
        true ->
            Start + (K - 1) div 1
    end.