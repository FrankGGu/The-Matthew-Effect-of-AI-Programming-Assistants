-module(sum_of_k_subarrays_with_length_at_least_m).
-export([minSumOfKSubarrays/2]).

minSumOfKSubarrays(Nums, K) ->
    N = length(Nums),
    M = 1,
    {MinSum, _} = lists:foldl(fun(I, {Acc, DP}) ->
        case I >= M of
            true ->
                Sub = lists:sublist(Nums, I - M + 1, M),
                Sum = lists:sum(Sub),
                NewDP = [Sum | DP],
                {Acc + Sum, NewDP};
            false ->
                {Acc, DP}
        end
    end, {0, []}, lists:seq(1, N)),
    MinSum.