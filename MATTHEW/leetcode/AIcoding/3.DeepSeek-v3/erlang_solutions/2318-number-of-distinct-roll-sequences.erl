-module(distinct_roll_sequences).
-export([distinct_sequences/1]).

distinct_sequences(N) ->
    Mod = 1000000007,
    if
        N == 1 -> 6;
        true ->
            DP = array:new([{size, N + 1}, {default, array:new([{size, 7}, {default, array:new([{size, 7}, {default, 0}])}])}]),
            DP1 = init_dp(DP),
            DP2 = fill_dp(DP1, N, Mod),
            sum_dp(DP2, N, Mod)
    end.

init_dp(DP) ->
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            array:set(I, array:set(J, array:set(0, 1, array:get(J, array:get(I, Acc1))), array:get(I, Acc1)), Acc1
        end, Acc, lists:seq(1, 6))
    end, DP, lists:seq(1, 6)).

fill_dp(DP, N, Mod) ->
    lists:foldl(fun(K, Acc) ->
        lists:foldl(fun(I, Acc1) ->
            lists:foldl(fun(J, Acc2) ->
                if
                    gcd(I, J) =/= 1, I =/= J ->
                        Sum = lists:foldl(fun(L, SumAcc) ->
                            if
                                gcd(J, L) =:= 1; J =:= L -> SumAcc;
                                true -> (SumAcc + array:get(L, array:get(J, array:get(K - 1, Acc2)))) rem Mod
                            end
                        end, 0, lists:seq(1, 6)),
                        array:set(K, array:set(J, array:set(I, Sum, array:get(J, array:get(K, Acc2)))), array:get(K, Acc2)), Acc2;
                    true -> Acc2
                end
            end, Acc1, lists:seq(1, 6))
        end, Acc, lists:seq(1, 6))
    end, DP, lists:seq(2, N)).

sum_dp(DP, N, Mod) ->
    lists:foldl(fun(I, Sum) ->
        lists:foldl(fun(J, Sum1) ->
            (Sum1 + array:get(J, array:get(I, array:get(N, DP)))) rem Mod
        end, Sum, lists:seq(1, 6))
    end, 0, lists:seq(1, 6)).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).