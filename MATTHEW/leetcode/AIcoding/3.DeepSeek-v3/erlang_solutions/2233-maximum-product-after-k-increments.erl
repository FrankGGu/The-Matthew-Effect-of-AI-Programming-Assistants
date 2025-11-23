-module(solution).
-export([maximum_product/2]).

maximum_product(Nums, K) ->
    Heap = lists:foldl(fun(N, Acc) -> 
                           heap:insert(-N, Acc) 
                       end, heap:new(), Nums),
    {Heap1, _} = lists:foldl(fun(_, {H, _}) -> 
                                [Min | Rest] = heap:extract(H),
                                NewMin = -Min + 1,
                                {heap:insert(-NewMin, Rest), NewMin}
                             end, {Heap, 0}, lists:seq(1, K)),
    lists:foldl(fun(N, Acc) -> 
                   (Acc * (-N)) rem 1000000007 
                end, 1, heap:to_list(Heap1)).