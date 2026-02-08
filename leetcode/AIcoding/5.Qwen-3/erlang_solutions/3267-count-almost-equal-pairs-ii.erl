-module(solution).
-export([count_almost_equal_pairs/1]).

count_almost_equal_pairs(Nums) ->
    Count = 0,
    N = length(Nums),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                I < J ->
                    A = lists:nth(I + 1, Nums),
                    B = lists:nth(J + 1, Nums),
                    Diff = abs(A - B),
                    if
                        Diff =< 2 -> Acc2 + 1;
                        true -> Acc2
                    end;
                true -> Acc2
            end
        end, Acc, lists:seq(I + 1, N - 1))
    end, Count, lists:seq(0, N - 1)).