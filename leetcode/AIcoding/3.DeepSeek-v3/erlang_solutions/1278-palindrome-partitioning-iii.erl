-module(solution).
-export([palindrome_partition/2]).

palindrome_partition(S, K) ->
    N = length(S),
    Cost = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    fill_cost(S, Cost, 0, N - 1),
    DP = array:new([{size, N + 1}, {default, array:new([{size, K + 1}, {default, 999999}])}]),
    DP1 = array:set(0, array:set(0, 0, array:get(0, DP)), DP,
    DP2 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case J =< I + 1 of
                true ->
                    Val = case J == 1 of
                        true -> array:get(I, array:get(0, Cost));
                        false ->
                            lists:min(lists:map(fun(P) ->
                                array:get(P, array:get(I, Cost)) + array:get(P, array:get(J - 1, array:get(I + 1, Acc)))
                            end, lists:seq(0, I - 1)))
                    end,
                    array:set(I + 1, array:set(J, Val, array:get(I + 1, Acc1)), Acc1);
                false -> Acc1
            end
        end, Acc, lists:seq(1, K))
    end, DP2, lists:seq(0, N - 1)),
    array:get(N, array:get(K, DP2)).

fill_cost(S, Cost, I, J) when I >= J -> Cost;
fill_cost(S, Cost, I, J) ->
    C1 = lists:nth(I + 1, S),
    C2 = lists:nth(J + 1, S),
    NewCost = case C1 == C2 of
        true -> 0;
        false -> 1
    end + array:get(I + 1, array:get(J - 1, Cost)),
    NewCostArr = array:set(J, NewCost, array:get(I, Cost)),
    NewCostArr2 = array:set(I, NewCostArr, Cost),
    fill_cost(S, NewCostArr2, I + 1, J - 1).