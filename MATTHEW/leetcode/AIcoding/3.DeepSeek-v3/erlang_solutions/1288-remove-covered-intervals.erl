-spec remove_covered_intervals(Intervals :: [[integer()]]) -> integer().
remove_covered_intervals(Intervals) ->
    Sorted = lists:sort(fun([A, B], [C, D]) ->
        if A =:= C -> B > D;
           true -> A < C
        end
    end, Intervals),
    {Count, _} = lists:foldl(fun([A, B], {Cnt, [PrevA, PrevB]}) ->
        if A >= PrevA andalso B <= PrevB ->
            {Cnt, [PrevA, PrevB]};
           true ->
            {Cnt + 1, [A, B]}
        end
    end, {0, [-1, -1]}, Sorted),
    Count.