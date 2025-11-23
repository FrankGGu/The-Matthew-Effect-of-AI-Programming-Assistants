-module(maximum_strong_pair_xor_ii).
-export([maximumStrongPairXOR/1]).

maximumStrongPairXOR(Nums) ->
    N = length(Nums),
    Max = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I /= J ->
                A = lists:nth(I + 1, Nums),
                B = lists:nth(J + 1, Nums),
                Diff = abs(A - B),
                if Diff =< (A bxor B) ->
                    MaxVal = A bxor B,
                    if MaxVal > Acc2 -> MaxVal;
                       true -> Acc2
                    end;
                true ->
                    Acc2
                end;
            true ->
                Acc2
            end
        end, Acc, lists:seq(0, N-1))
    end, Max, lists:seq(0, N-1)).