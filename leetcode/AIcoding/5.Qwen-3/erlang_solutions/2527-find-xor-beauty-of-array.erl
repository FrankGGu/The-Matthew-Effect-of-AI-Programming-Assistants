-module(solution).
-export([xor_beauty_of_array/1]).

xor_beauty_of_array(Nums) ->
    N = length(Nums),
    Result = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            lists:foldl(fun(K, Acc3) ->
                lists:foldl(fun(L, Acc4) ->
                    Acc4 bxor (lists:nth(I+1, Nums) bxor lists:nth(J+1, Nums) bxor lists:nth(K+1, Nums) bxor lists:nth(L+1, Nums))
                end, Acc3, lists:seq(0, N-1))
            end, Acc2, lists:seq(0, N-1))
        end, Acc, lists:seq(0, N-1))
    end, 0, lists:seq(0, N-1)),
    Result.