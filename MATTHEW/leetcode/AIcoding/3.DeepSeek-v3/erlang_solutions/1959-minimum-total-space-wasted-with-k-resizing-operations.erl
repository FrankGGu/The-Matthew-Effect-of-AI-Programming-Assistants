-module(solution).
-export([min_space_wasted_k_resizing/2]).

min_space_wasted_k_resizing(Nums, K) ->
    N = length(Nums),
    Prefix = prefix_sum(Nums),
    Max = max_table(Nums),
    DP = init_dp(N, K),
    DP1 = fill_dp(DP, N, K, Prefix, Max),
    element(N, element(K + 1, DP1)).

prefix_sum(Nums) ->
    lists:foldl(fun(X, [H|T]) -> [H + X | [H|T]] end, [0], Nums).

max_table(Nums) ->
    N = length(Nums),
    Table = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])})]),
    lists:foldl(fun(I, T) ->
        lists:foldl(fun(J, Acc) ->
            M = if I =:= J -> lists:nth(I + 1, Nums);
                   true -> max(lists:nth(J + 1, Nums), array:get(J - 1, array:get(I, Acc)))
                end,
            array:set(J, M, array:get(I, Acc))
        end, T, lists:seq(I, N - 1))
    end, Table, lists:seq(0, N - 1)).

init_dp(N, K) ->
    array:new([{size, K + 1}, 
               {default, array:new([{size, N + 1}, 
                                    {default, 999999999}])}]).

fill_dp(DP, N, K, Prefix, Max) ->
    lists:foldl(fun(I, Dp) ->
        lists:foldl(fun(J, D) ->
            case I =:= 0 of
                true ->
                    M = array:get(J - 1, array:get(0, Max)),
                    Sum = lists:nth(J + 1, Prefix) - lists:nth(1, Prefix),
                    Val = M * J - Sum,
                    array:set(0, array:set(J, Val, array:get(0, D)), D);
                false ->
                    lists:foldl(fun(L, Acc) ->
                        M = array:get(L, array:get(J - 1, Max)),
                        Sum = lists:nth(J + 1, Prefix) - lists:nth(L + 1, Prefix),
                        Current = M * (J - L) - Sum + array:get(I - 1, array:get(L, array:get(I, Acc))),
                        Prev = array:get(J, array:get(I, Acc)),
                        NewVal = min(Current, Prev),
                        array:set(I, array:set(J, NewVal, array:get(I, Acc)), Acc)
                    end, D, lists:seq(0, J - 1))
            end
        end, Dp, lists:seq(1, N))
    end, DP, lists:seq(0, K)).