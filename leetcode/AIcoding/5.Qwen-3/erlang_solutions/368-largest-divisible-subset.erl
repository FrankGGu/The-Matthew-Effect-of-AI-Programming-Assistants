-module(largest_divisible_subset).
-export([largest_divisible_subset/1]).

largest_divisible_subset(Nums) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    {_, Result} = lists:foldl(fun(I, {MaxLen, MaxSubset}) ->
        {Count, Subset} = lists:foldl(fun(J, {C, S}) ->
            if
                I /= J, Sorted[I] rem Sorted[J] == 0 ->
                    {C + 1, [Sorted[J] | S]};
                true ->
                    {C, S}
            end
        end, {1, [Sorted[I]]}, lists:seq(0, I - 1)),
        if
            Count > MaxLen ->
                {Count, Subset};
            true ->
                {MaxLen, MaxSubset}
        end
    end, {0, []}, lists:seq(0, N - 1)),
    lists:reverse(Result).