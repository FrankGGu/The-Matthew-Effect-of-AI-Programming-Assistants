-module(solution).
-export([equal_triplets/1]).

equal_triplets(Nums) ->
    N = length(Nums),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I < J ->
                lists:foldl(fun(K, Acc3) ->
                    if J < K andalso lists:nth(I+1, Nums) /= lists:nth(J+1, Nums) andalso lists:nth(J+1, Nums) /= lists:nth(K+1, Nums) andalso lists:nth(I+1, Nums) /= lists:nth(K+1, Nums) ->
                        Acc3 + 1;
                    true ->
                        Acc3
                    end
                end, Acc2, lists:seq(J+1, N-1));
            true ->
                Acc2
            end
        end, Acc, lists:seq(I+1, N-1))
    end, Count, lists:seq(0, N-3)).