-spec largest_sum_of_averages(Nums :: [integer()], K :: integer()) -> float().
largest_sum_of_averages(Nums, K) ->
    N = length(Nums),
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Nums),
    PrefixSum = lists:reverse(Prefix),
    DP = lists:duplicate(N + 1, lists:duplicate(K + 1, 0.0)),
    DP1 = lists:foldl(fun(I, Dp) ->
        lists:foldl(fun(J, Dp1) ->
            if
                J == 1 ->
                    set(I, J, (lists:nth(I, PrefixSum) - lists:nth(1, PrefixSum)) / (I - 1), Dp1);
                true ->
                    lists:foldl(fun(X, Dp2) ->
                        Current = get(I, J - 1, Dp2) + (lists:nth(I, PrefixSum) - lists:nth(X, PrefixSum)) / (I - X),
                        Prev = get(I, J, Dp2),
                        if
                            Current > Prev -> set(I, J, Current, Dp2);
                            true -> Dp2
                        end
                    end, Dp1, lists:seq(1, I - 1))
            end
        end, Dp, lists:seq(1, K))
    end, DP, lists:seq(1, N)),
    get(N, K, DP1).

set(I, J, Val, DP) ->
    Row = lists:nth(I, DP),
    NewRow = setelement(J, list_to_tuple(Row), Val),
    setelement(I, list_to_tuple(DP), tuple_to_list(NewRow)).

get(I, J, DP) ->
    Row = lists:nth(I, DP),
    element(J, list_to_tuple(Row)).