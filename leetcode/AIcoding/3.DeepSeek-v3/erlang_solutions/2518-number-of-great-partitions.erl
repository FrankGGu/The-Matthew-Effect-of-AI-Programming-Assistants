-module(solution).
-export([count_partitions/2]).

count_partitions(Nums, K) ->
    Total = lists:sum(Nums),
    if
        Total < 2 * K -> 0;
        true ->
            Mod = 1000000007,
            DP = lists:foldl(fun(Num, Acc) ->
                lists:foldl(fun(J, Dp) ->
                    if
                        J >= Num -> (Dp + lists:nth(J - Num + 1, Acc)) rem Mod;
                        true -> Dp rem Mod
                    end
                end, 0, lists:seq(length(Acc), 1, -1))
            end, [1 | lists:duplicate(K - 1, 0)], Nums),
            Sum = lists:foldl(fun(I, SumAcc) -> (SumAcc + lists:nth(I + 1, DP)) rem Mod end, 0, lists:seq(0, K - 1)),
            (pow(2, length(Nums), Mod) - 2 * Sum) rem Mod
    end.

pow(_, 0, _) -> 1;
pow(A, B, Mod) ->
    if
        B rem 2 == 0 -> (pow((A * A) rem Mod, B div 2, Mod)) rem Mod;
        true -> (A * pow((A * A) rem Mod, B div 2, Mod)) rem Mod
    end.