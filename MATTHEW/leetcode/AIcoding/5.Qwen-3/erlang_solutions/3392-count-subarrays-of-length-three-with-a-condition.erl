-module(solution).
-export([num_subarrays/1]).

num_subarrays(Nums) ->
    Count = 0,
    Len = length(Nums),
    if
        Len < 3 -> 0;
        true ->
            lists:foldl(fun(I, Acc) ->
                                A = lists:nth(I, Nums),
                                B = lists:nth(I+1, Nums),
                                C = lists:nth(I+2, Nums),
                                if
                                    (A < B andalso B < C) -> Acc + 1;
                                    true -> Acc
                                end
                            end, Count, lists:seq(1, Len - 2)).
end.