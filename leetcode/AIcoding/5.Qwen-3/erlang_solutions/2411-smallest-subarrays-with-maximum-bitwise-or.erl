-module(solution).
-export([smallest_subarrays/1]).

smallest_subarrays(Nums) ->
    N = length(Nums),
    Result = lists:seq(0, N-1),
    lists:map(fun(I) -> find_smallest_subarray(Nums, I) end, Result).

find_smallest_subarray(Nums, I) ->
    MaxOr = lists:nth(I+1, Nums),
    J = I,
    OrVal = MaxOr,
    find_smallest_subarray(Nums, I, J, OrVal).

find_smallest_subarray(Nums, I, J, OrVal) ->
    if
        J >= length(Nums) -> J - I;
        true ->
            NextOr = OrVal bor lists:nth(J+1, Nums),
            if
                NextOr > OrVal ->
                    find_smallest_subarray(Nums, I, J+1, NextOr);
                true ->
                    J - I
            end
    end.