-module(solution).
-export([num_triplets/1]).

num_triplets(Nums) ->
    N = length(Nums),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I < J ->
                lists:foldl(fun(K, Acc3) ->
                    if J < K ->
                        case (lists:nth(I+1, Nums) band lists:nth(J+1, Nums)) band lists:nth(K+1, Nums) of
                            0 -> Acc3 + 1;
                            _ -> Acc3
                        end;
                    true -> Acc3
                end, Acc2, lists:seq(K, N-1));
            true -> Acc2
        end, Acc, lists:seq(J, N-1))
    end, Count, lists:seq(I, N-1)).

num_triplets(_Nums) -> 0.