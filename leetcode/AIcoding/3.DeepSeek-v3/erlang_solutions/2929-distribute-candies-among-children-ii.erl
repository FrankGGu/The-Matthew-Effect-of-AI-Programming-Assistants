-spec distribute_candies(integer(), integer()) -> integer().
distribute_candies(N, Limit) ->
    count_ways(0, 0, N, Limit, 0).

count_ways(_, _, N, _, Count) when N < 0 ->
    Count;
count_ways(3, _, 0, _, Count) ->
    Count + 1;
count_ways(3, _, _, _, Count) ->
    Count;
count_ways(I, _, _, _, Count) when I >= 3 ->
    Count;
count_ways(I, Prev, N, Limit, Count) ->
    lists:foldl(fun(K, Acc) ->
                    if
                        K > Limit -> Acc;
                        true -> count_ways(I + 1, K, N - K, Limit, Acc)
                    end
                end, Count, lists:seq(0, Limit)).