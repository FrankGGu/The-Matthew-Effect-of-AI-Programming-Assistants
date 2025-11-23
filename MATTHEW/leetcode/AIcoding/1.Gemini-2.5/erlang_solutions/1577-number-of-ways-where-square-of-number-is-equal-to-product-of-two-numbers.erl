-module(solution).
-export([numTriplets/2]).

numTriplets(Nums1, Nums2) ->
    ProductFreq1 = build_product_frequency(Nums1),
    ProductFreq2 = build_product_frequency(Nums2),

    TotalWays1 = lists:foldl(fun(N1, Acc) ->
                                 Square = N1 * N1,
                                 case maps:find(Square, ProductFreq2) of
                                     {ok, Count} -> Acc + Count;
                                     _ -> Acc
                                 end
                             end, 0, Nums1),

    TotalWays2 = lists:foldl(fun(N2, Acc) ->
                                 Square = N2 * N2,
                                 case maps:find(Square, ProductFreq1) of
                                     {ok, Count} -> Acc + Count;
                                     _ -> Acc
                                 end
                             end, 0, Nums2),

    TotalWays1 + TotalWays2.

build_product_frequency(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) ->
                              maps:update_with(N, fun(C) -> C + 1 end, 1, Acc)
                          end, #{}, Nums),

    ProductFreq = #{},
    Keys = maps:keys(FreqMap),

    lists:foldl(fun(Val1, AccProductFreq1) ->
                    Count1 = maps:get(Val1, FreqMap),
                    lists:foldl(fun(Val2, AccProductFreq2) ->
                                    Count2 = maps:get(Val2, FreqMap),
                                    if Val1 < Val2 ->
                                        Product = Val1 * Val2,
                                        maps:update_with(Product, fun(C) -> C + Count1 * Count2 end, Count1 * Count2, AccProductFreq2);
                                    Val1 == Val2 ->
                                        Product = Val1 * Val1,
                                        Combinations = Count1 * (Count1 - 1) div 2,
                                        maps:update_with(Product, fun(C) -> C + Combinations end, Combinations, AccProductFreq2);
                                    true ->
                                        AccProductFreq2
                                    end
                                end, AccProductFreq1, Keys)
                end, ProductFreq, Keys).