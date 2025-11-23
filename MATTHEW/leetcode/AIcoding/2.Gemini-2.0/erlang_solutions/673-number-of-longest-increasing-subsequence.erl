-module(number_of_lis).
-export([find_number_of_lis/1]).

find_number_of_lis(Nums) ->
    N = length(Nums),
    {Lengths, Counts} = lists:foldl(
        fun(Num, {AccLengths, AccCounts}) ->
            {MaxLength, MaxCount} = lists:foldl(
                fun(I, {ML, MC}) ->
                    if Nums !! I < Num then
                        NewLength = (lists:nth(I + 1, AccLengths)) + 1,
                        if NewLength > ML then
                            {NewLength, lists:nth(I + 1, AccCounts)}
                        else if NewLength == ML then
                            {ML, MC + lists:nth(I + 1, AccCounts)}
                        else
                            {ML, MC}
                        end
                    else
                        {ML, MC}
                    end
                end, {1, 1}, lists:seq(0, length(AccLengths) - 2)
            ),
            {AccLengths ++ [MaxLength], AccCounts ++ [MaxCount]}
        end, {[], []}, Nums
    ),

    MaxLength = lists:max(Lengths),
    lists:foldl(
        fun(I, Acc) ->
            if lists:nth(I + 1, Lengths) == MaxLength then
                Acc + lists:nth(I + 1, Counts)
            else
                Acc
            end
        end, 0, lists:seq(0, N - 1)
    ).