-module(solution).
-export([kthSmallestProduct/3]).

bin_search_upper_bound(Arr, Value) ->
    Low = 0,
    High = array:size(Arr),
    bin_search_upper_bound_loop(Arr, Value, Low, High).

bin_search_upper_bound_loop(_Arr, _Value, Low, High) when Low >= High -> Low;
bin_search_upper_bound_loop(Arr, Value, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = array:get(Mid, Arr),
    if
        Element =< Value ->
            bin_search_upper_bound_loop(Arr, Value, Mid + 1, High);
        true ->
            bin_search_upper_bound_loop(Arr, Value, Low, Mid)
    end.

bin_search_lower_bound(Arr, Value) ->
    Low = 0,
    High = array:size(Arr),
    bin_search_lower_bound_loop(Arr, Value, Low, High).

bin_search_lower_bound_loop(_Arr, _Value, Low, High) when Low >= High -> Low;
bin_search_lower_bound_loop(Arr, Value, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = array:get(Mid, Arr),
    if
        Element < Value ->
            bin_search_lower_bound_loop(Arr, Value, Mid + 1, High);
        true ->
            bin_search_lower_bound_loop(Arr, Value, Low, Mid)
    end.

count_le(Target, Nums1, Nums2Arr) ->
    Nums2Size = array:size(Nums2Arr),
    lists:foldl(fun(X, Acc) ->
        if
            X == 0 ->
                if Target >= 0 -> Acc + Nums2Size;
                true -> Acc
                end;
            X > 0 ->
                Val = trunc(floor(Target / X)),
                Acc + bin_search_upper_bound(Nums2Arr, Val);
            true -> %% X < 0
                Val = trunc(ceil(Target / X)),
                Acc + (Nums2Size - bin_search_lower_bound(Nums2Arr, Val))
        end
    end, 0, Nums1).

kthSmallestProduct(Nums1, Nums2, K) ->
    Nums2Arr = array:from_list(Nums2),

    %% Binary search range for the answer.
    %% The minimum possible product is -10^5 * 10^5 = -10^10.
    %% The maximum possible product is 10^5 * 10^5 = 10^10.
    Low = -10000000000,
    High = 10000000000,

    %% Initial 'Ans' is High, as we are searching for the smallest value that satisfies the condition.
    binary_search_product(Nums1, Nums2Arr, K, Low, High, High).

binary_search_product(_Nums1, _Nums2Arr, _K, Low, High, Ans) when Low > High -> Ans;
binary_search_product(Nums1, Nums2Arr, K, Low, High, CurrentAns) ->
    Mid = Low + (High - Low) div 2,
    Count = count_le(Mid, Nums1, Nums2Arr),
    if
        Count >= K ->
            %% If Count >= K, Mid could be the answer or the answer is smaller.
            %% We try to find a smaller answer in the left half.
            binary_search_product(Nums1, Nums2Arr, K, Low, Mid - 1, Mid);
        true ->
            %% If Count < K, Mid is too small. We need a larger product.
            %% Search in the right half.
            binary_search_product(Nums1, Nums2Arr, K, Mid + 1, High, CurrentAns)
    end.