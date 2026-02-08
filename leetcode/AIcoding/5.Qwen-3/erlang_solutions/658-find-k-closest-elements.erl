-module(k_closest_elements).
-export([find_k_closest/2]).

find_k_closest(Arr, K) ->
    find_k_closest(Arr, K, 0, length(Arr) - 1).

find_k_closest(Arr, K, left, right) when left =< right ->
    Mid = (left + right) div 2,
    if
        Mid + 1 =< length(Arr) - 1 andalso abs(Arr ! Mid) > abs(Arr ! (Mid + 1)) ->
            find_k_closest(Arr, K, Mid + 1, right);
        Mid - 1 >= 0 andalso abs(Arr ! Mid) > abs(Arr ! (Mid - 1)) ->
            find_k_closest(Arr, K, left, Mid - 1);
        true ->
            start = max(0, Mid - K + 1),
            end = min(length(Arr) - 1, Mid + K - 1),
            lists:sublist(Arr, start + 1, end - start + 1)
    end.