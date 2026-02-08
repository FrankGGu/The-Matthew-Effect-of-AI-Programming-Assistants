-module(k_strongest_values_in_array).
-export([kStrongest/2]).

kStrongest(Arr, K) ->
    Sorted = lists:sort(Arr),
    N = length(Sorted),
    Mid = (N - 1) div 2,
    Median = lists:nth(Mid + 1, Sorted),
    Strongest = lists:sort(fun(A, B) ->
        if
            abs(A - Median) > abs(B - Median) -> true;
            abs(A - Median) == abs(B - Median) -> A > B;
            true -> false
        end
    end, Sorted),
    lists:sublist(Strongest, K).