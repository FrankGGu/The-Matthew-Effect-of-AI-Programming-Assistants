-spec maximum_distinct_elements(Nums :: [integer()], K :: integer()) -> integer().
maximum_distinct_elements(Nums, K) ->
    Freq = lists:foldl(fun(N, Acc) -> 
                           maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
                       end, #{}, Nums),
    {Distinct, Duplicates} = maps:fold(fun(_, V, {D, Dup}) -> 
                                           if V =:= 1 -> {D + 1, Dup};
                                              true -> {D, [V - 1 | Dup]}
                                           end
                                       end, {0, []}, Freq),
    SortedDup = lists:sort(Duplicates),
    calculate_max(SortedDup, K, Distinct).

calculate_max([], K, Distinct) ->
    min(Distinct + K, maps:size(Freq));
calculate_max([Dup | Rest], K, Distinct) when K >= Dup ->
    calculate_max(Rest, K - Dup, Distinct + 1);
calculate_max(_, K, Distinct) ->
    Distinct + K.