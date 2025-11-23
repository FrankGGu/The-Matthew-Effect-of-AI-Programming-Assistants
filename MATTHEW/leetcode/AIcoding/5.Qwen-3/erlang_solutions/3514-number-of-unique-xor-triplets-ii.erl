-module(solution).
-export([unique_xor_triplets/1]).

unique_xor_triplets(Nums) ->
    N = length(Nums),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I < J ->
                lists:foldl(fun(K, Acc3) ->
                    if J < K ->
                        A = lists:nth(I+1, Nums),
                        B = lists:nth(J+1, Nums),
                        C = lists:nth(K+1, Nums),
                        Xor = A bxor B bxor C,
                        case lists:member(Xor, Acc3) of
                            true -> Acc3;
                            false -> [Xor | Acc3]
                        end;
                    true -> Acc3
                end, Acc2, lists:seq(K, N-1))
            ; true -> Acc2
        end, Acc, lists:seq(J, N-1))
    end, [], lists:seq(I, N-1)).

unique_xor_triplets(_) -> 0.