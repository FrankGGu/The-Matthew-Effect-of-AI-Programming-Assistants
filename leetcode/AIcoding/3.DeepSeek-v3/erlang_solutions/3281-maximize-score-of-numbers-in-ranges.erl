-module(solution).
-export([max_sum/2]).

max_sum(Nums, Ranges) ->
    N = length(Nums),
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Nums)),
    PrefixSum = lists:reverse(Prefix),

    DP = lists:foldl(fun(_, Acc) -> [0 || _ <- lists:seq(1, N+1)] end, [], lists:seq(1, N+1)),

    lists:foldl(fun(I, Dp) ->
        lists:foldl(fun(J, DpRow) ->
            Max = lists:max([lists:nth(J, DpRow), lists:nth(I, DpRow) + lists:nth(J+1, lists:nth(I, Dp))]),
            setelement(J, DpRow, Max)
        end, Dp, lists:seq(1, N))
    end, DP, lists:seq(1, N)),

    lists:foldl(fun([L, R], Acc) ->
        Acc + (lists:nth(R+1, PrefixSum) - lists:nth(L, PrefixSum)
    end, 0, Ranges).