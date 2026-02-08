-module(solution).
-export([find_subarrays_with_equal_sum/1]).

find_subarrays_with_equal_sum(Nums) ->
    find_subarrays_with_equal_sum_recursive(Nums, sets:new()).

find_subarrays_with_equal_sum_recursive([_] = _Nums, _SeenSums) ->
    false;
find_subarrays_with_equal_sum_recursive([A, B | Rest], SeenSums) ->
    CurrentSum = A + B,
    case sets:is_element(CurrentSum, SeenSums) of
        true ->
            true;
        false ->
            NewSeenSums = sets:add_element(CurrentSum, SeenSums),
            find_subarrays_with_equal_sum_recursive([B | Rest], NewSeenSums)
    end;
find_subarrays_with_equal_sum_recursive([], _SeenSums) ->
    false.