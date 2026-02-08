-module(solution).
-export([count_monotonic_pairs/1]).

count_monotonic_pairs(Nums) ->
    N = length(Nums),
    DP = array:new(N, {default, 0}),
    count_monotonic_pairs(Nums, N, DP, 0).

count_monotonic_pairs(_, _, _, N) -> 0;
count_monotonic_pairs(Nums, N, DP, I) ->
    case array:get(I, DP) of
        V when is_integer(V) -> V;
        _ ->
            Count = count_monotonic_pairs_helper(Nums, N, I, 0),
            array:set(I, Count, DP),
            Count
    end.

count_monotonic_pairs_helper(_, _, _, J) when J >= 0 -> 0;
count_monotonic_pairs_helper(Nums, N, I, J) ->
    if
        J < I ->
            if
                lists:nth(J + 1, Nums) <= lists:nth(I + 1, Nums) ->
                    count_monotonic_pairs_helper(Nums, N, I, J + 1) + 
                    count_monotonic_pairs(Nums, N, array:new(N, {default, 0}), J);
                true ->
                    count_monotonic_pairs_helper(Nums, N, I, J + 1)
            end;
        true ->
            0
    end.