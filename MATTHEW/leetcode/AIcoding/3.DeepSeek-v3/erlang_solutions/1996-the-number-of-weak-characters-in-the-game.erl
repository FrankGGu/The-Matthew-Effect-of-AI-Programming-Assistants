-spec number_of_weak_characters(Properties :: [[integer()]]) -> integer().
number_of_weak_characters(Properties) ->
    Sorted = lists:sort(fun([A1, D1], [A2, D2]) -> 
                            if A1 =:= A2 -> D1 > D2;
                               true -> A1 < A2
                            end
                         end, Properties),
    {Count, _} = lists:foldl(fun([_, D], {C, MaxD}) -> 
                                if D < MaxD -> {C + 1, MaxD};
                                   true -> {C, max(D, MaxD)}
                                end
                            end, {0, -1}, Sorted),
    Count.