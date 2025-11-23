-module(solution).
-export([max_non_overlapping_subarrays/2]).

max_non_overlapping_subarrays(Nums, Target) ->
    {Count, _, _} = lists:foldl(
        fun(Num, {AccCount, AccSum, AccPrefixSums}) ->
            NewSum = AccSum + Num,
            RequiredSum = NewSum - Target,
            case gb_sets:is_member(RequiredSum, AccPrefixSums) of
                true ->
                    {AccCount + 1, 0, gb_sets:from_list([0])}
                false ->
                    {AccCount, NewSum, gb_sets:add(NewSum, AccPrefixSums)}
            end
        end,
        {0, 0, gb_sets:from_list([0])},
        Nums
    ),
    Count.