-module(solution).
-export([minimumDeletions/1]).

minimumDeletions(Nums) ->
    OriginalLength = length(Nums),
    {FinalKeptCount, _} = lists:foldl(
        fun(N, {KeptCount, LastKeptValue}) ->
            if
                KeptCount rem 2 == 0 ->
                    {KeptCount + 1, N};
                KeptCount rem 2 == 1 ->
                    if
                        N =/= LastKeptValue ->
                            {KeptCount + 1, N};
                        true ->
                            {KeptCount, LastKeptValue}
                    end
            end
        end,
        {0, -1},
        Nums
    ),

    AdjustedKeptCount = if
                            FinalKeptCount rem 2 == 1 -> FinalKeptCount - 1;
                            true -> FinalKeptCount
                        end,

    OriginalLength - AdjustedKeptCount.