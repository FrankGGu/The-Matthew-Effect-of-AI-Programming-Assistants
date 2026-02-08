-module(kth_largest_integer).
-export([kthLargestInteger/2]).

kthLargestInteger(Nums, K) ->
    Sorted = lists:sort(fun(A, B) -> 
        case length(A) - length(B) of
            0 -> A >= B;
            Diff when Diff < 0 -> true;
            _ -> false
        end
    end, Nums),
    lists:nth(length(Sorted) - K + 1, Sorted).