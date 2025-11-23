-spec number_of_beams(Bank :: [unicode:unicode_binary()]) -> integer().
number_of_beams(Bank) ->
    lists:foldl(fun(Row, {PrevCount, Total}) ->
        Count = count_ones(Row),
        if
            Count > 0 -> {Count, Total + PrevCount * Count};
            true -> {PrevCount, Total}
        end
    end, {0, 0}, Bank),
    {_, Result} = lists:foldl(fun(Row, {PrevCount, Total}) ->
        Count = count_ones(Row),
        if
            Count > 0 -> {Count, Total + PrevCount * Count};
            true -> {PrevCount, Total}
        end
    end, {0, 0}, Bank),
    Result.

count_ones(Row) ->
    lists:foldl(fun(Ch, Acc) ->
        if
            Ch =:= $1 -> Acc + 1;
            true -> Acc
        end
    end, 0, binary_to_list(Row)).