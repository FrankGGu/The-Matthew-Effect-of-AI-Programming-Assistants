-module(solution).
-export([num_ways/2]).

num_ways(Nums1, Nums2) ->
    Count = 0,
    Map = maps:from_list([{N, 0} || N <- Nums1 ++ Nums2]),
    lists:foreach(fun(N) -> maps:update(N, maps:get(N, Map) + 1, Map) end, Nums1 ++ Nums2),
    lists:foldl(fun(N1, Acc) ->
        lists:foldl(fun(N2, Acc2) ->
            Square = N1 * N1,
            if
                Square == N1 * N2 ->
                    Acc2 + maps:get(Square, Map, 0);
                true ->
                    Acc2
            end
        end, Acc, Nums2)
    end, Count, Nums1).