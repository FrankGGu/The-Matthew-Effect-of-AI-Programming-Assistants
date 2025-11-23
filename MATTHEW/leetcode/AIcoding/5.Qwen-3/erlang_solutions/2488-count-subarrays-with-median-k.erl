-module(solution).
-export([main/1]).

main(Args) ->
    [NStr, KStr | Rest] = string:split(Args, " "),
    N = list_to_integer(NStr),
    K = list_to_integer(KStr),
    Arr = lists:map(fun(X) -> list_to_integer(X) end, Rest),
    count_subarrays_with_median_k(Arr, K).

count_subarrays_with_median_k(Arr, K) ->
    Len = length(Arr),
    Count = 0,
    count_subarrays_with_median_k(Arr, K, 0, Count).

count_subarrays_with_median_k(_, _, Index, Count) when Index >= length(Arr) ->
    Count;
count_subarrays_with_median_k(Arr, K, Index, Count) ->
    SubArr = lists:sublist(Arr, Index + 1),
    Sorted = lists:sort(SubArr),
    Mid = (length(Sorted) - 1) div 2,
    if
        lists:nth(Mid + 1, Sorted) == K ->
            count_subarrays_with_median_k(Arr, K, Index + 1, Count + 1);
        true ->
            count_subarrays_with_median_k(Arr, K, Index + 1, Count)
    end.