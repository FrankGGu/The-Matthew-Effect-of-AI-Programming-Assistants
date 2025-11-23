-module(solution).
-export([kth_smallest_product/3]).

kth_smallest_product(A, B, k) ->
    Min = hd(A) * hd(B),
    Max = hd(lists:last(A)) * hd(lists:last(B)),
    kth_smallest_product_helper(A, B, k, Min, Max).

kth_smallest_product_helper(A, B, k, Min, Max) ->
    case Min >= Max of
        true -> Min;
        false ->
            Mid = (Min + Max) div 2,
            Count = count_less_equal(A, B, Mid),
            case Count < k of
                true -> kth_smallest_product_helper(A, B, k, Mid + 1, Max);
                false -> kth_smallest_product_helper(A, B, k, Min, Mid);
            end
    end.

count_less_equal(A, B, x) ->
    lists:foldl(fun (a, acc) -> acc + count_in_b(B, div(x, a)) end, 0, A).

count_in_b(B, limit) ->
    case lists:filter(fun (b) -> b <= limit end, B) of
        [] -> 0;
        List -> length(List)
    end.