-module(solution).
-export([number_of_good_partitions/1]).

number_of_good_partitions(Nums) ->
    LastPos = maps:from_list(lists:zip(Nums, lists:seq(0, length(Nums) - 1))),
    {Res, _} = count_partitions(Nums, 0, 0, LastPos, 1, 1),
    Res.

count_partitions([], _, _, _, Res, _) -> {Res, 0};
count_partitions([H | T], I, MaxPos, LastPos, Res, Current) ->
    CurrentMax = max(MaxPos, maps:get(H, LastPos)),
    if
        CurrentMax == I ->
            {NewRes, NewCurrent} = count_partitions(T, I + 1, CurrentMax, LastPos, Res * 2 rem 1000000007, 1),
            {NewRes, NewCurrent};
        true ->
            count_partitions(T, I + 1, CurrentMax, LastPos, Res, Current + 1)
    end.