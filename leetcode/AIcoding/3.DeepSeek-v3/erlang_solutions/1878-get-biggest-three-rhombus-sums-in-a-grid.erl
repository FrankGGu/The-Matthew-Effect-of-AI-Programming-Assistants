-spec get_biggest_three(Grid :: [[integer()]]) -> [integer()].
get_biggest_three(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Sums = sets:new(),
    Sums1 = find_rhombus_sums(Grid, M, N, Sums),
    Sorted = lists:reverse(lists:sort(sets:to_list(Sums1))),
    case length(Sorted) of
        0 -> [];
        1 -> [lists:nth(1, Sorted)];
        2 -> [lists:nth(1, Sorted), lists:nth(2, Sorted)];
        _ -> [lists:nth(1, Sorted), lists:nth(2, Sorted), lists:nth(3, Sorted)]
    end.

find_rhombus_sums(Grid, M, N, Sums) ->
    lists:foldl(fun(I, Acc1) ->
        lists:foldl(fun(J, Acc2) ->
            MaxK = min(min(I, M - I - 1), min(J, N - J - 1)),
            lists:foldl(fun(K, Acc3) ->
                Sum = calculate_rhombus_sum(Grid, I, J, K),
                sets:add_element(Sum, Acc3)
            end, Acc2, lists:seq(0, MaxK))
        end, Acc1, lists:seq(0, N - 1))
    end, Sums, lists:seq(0, M - 1)).

calculate_rhombus_sum(Grid, I, J, K) ->
    if
        K == 0 -> lists:nth(J + 1, lists:nth(I + 1, Grid));
        true ->
            Sum = 0,
            {Sum1, _} = lists:foldl(fun(Dk, {S, Dj}) ->
                S1 = S + lists:nth(J - Dj + 1, lists:nth(I - Dk + 1, Grid)) +
                         lists:nth(J + Dj + 1, lists:nth(I - Dk + 1, Grid)) +
                         lists:nth(J - Dj + 1, lists:nth(I + Dk + 1, Grid)) +
                         lists:nth(J + Dj + 1, lists:nth(I + Dk + 1, Grid)),
                {S1, Dj + 1}
            end, {Sum, 0}, lists:seq(0, K - 1)),
            Sum1 + lists:nth(J - K + 1, lists:nth(I + 1, Grid)) +
                  lists:nth(J + K + 1, lists:nth(I + 1, Grid)) -
                  lists:nth(J + 1, lists:nth(I - K + 1, Grid)) -
                  lists:nth(J + 1, lists:nth(I + K + 1, Grid))
    end.