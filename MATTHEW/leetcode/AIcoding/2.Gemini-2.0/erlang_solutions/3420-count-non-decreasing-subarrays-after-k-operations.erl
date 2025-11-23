-module(solution).
-export([count_non_decreasing_subarrays_after_k_operations/2]).

count_non_decreasing_subarrays_after_k_operations(Nums, K) ->
    count_valid_subarrays(Nums, K).

count_valid_subarrays(Nums, K) ->
    N = length(Nums),
    count_valid_subarrays_helper(Nums, K, 0, N - 1, 0).

count_valid_subarrays_helper(_Nums, _K, I, N, Count) when I > N ->
    Count;
count_valid_subarrays_helper(Nums, K, I, N, Count) ->
    count_valid_subarrays_helper2(Nums, K, I, I, N, Count).

count_valid_subarrays_helper2(_Nums, _K, _I, J, N, Count) when J > N ->
    Count;
count_valid_subarrays_helper2(Nums, K, I, J, N, Count) ->
    Subarray = lists:sublist(Nums, I + 1, J - I + 1),
    case is_valid_subarray(Subarray, K) of
        true ->
            count_valid_subarrays_helper2(Nums, K, I, J + 1, N, Count + 1);
        false ->
            count_valid_subarrays_helper2(Nums, K, I, J + 1, N, Count)
    end.

is_valid_subarray(Subarray, K) ->
    N = length(Subarray),
    is_valid_subarray_helper(Subarray, K, 0, N - 1).

is_valid_subarray_helper(_Subarray, _K, I, N) when I >= N ->
    true;
is_valid_subarray_helper(Subarray, K, I, N) ->
    case check_non_decreasing_with_k(Subarray, K) of
        true ->
            true;
        false ->
            false
    end.

check_non_decreasing_with_k(Subarray, K) ->
    N = length(Subarray),
    check_non_decreasing_with_k_helper(Subarray, K, 0, N - 1).

check_non_decreasing_with_k_helper(_Subarray, _K, I, N) when I >= N ->
    true;
check_non_decreasing_with_k_helper(Subarray, K, I, N) ->
    case is_non_decreasing_with_k(Subarray, K) of
        true ->
            true;
        false ->
            false
    end.

is_non_decreasing_with_k(Subarray, K) ->
    N = length(Subarray),
    case N of
        0 ->
            true;
        1 ->
            true;
        _ ->
            is_non_decreasing_with_k_helper(Subarray, K, 0, N - 1)
    end.

is_non_decreasing_with_k_helper(_Subarray, _K, I, N) when I >= N - 1 ->
    true;
is_non_decreasing_with_k_helper(Subarray, K, I, N) ->
    case is_non_decreasing(Subarray, K, I) of
        true ->
            is_non_decreasing_with_k_helper(Subarray, K, I + 1, N);
        false ->
            false
    end.

is_non_decreasing(Subarray, K, I) ->
    case lists:nth(I + 1, Subarray) =< lists:nth(I + 2, Subarray) of
        true ->
            true;
        false ->
            Diff = lists:nth(I + 1, Subarray) - lists:nth(I + 2, Subarray),
            case Diff =< K of
                true ->
                    true;
                false ->
                    false
            end
    end.