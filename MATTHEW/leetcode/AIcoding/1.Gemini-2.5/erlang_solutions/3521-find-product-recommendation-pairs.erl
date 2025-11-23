-module(solution).
-export([solution/1]).

solution(Purchases) ->
    UserProductsMap = lists:foldl(
        fun([User, Product], AccMap) ->
            maps:update_with(User, fun(ExistingProducts) -> sets:add_element(Product, ExistingProducts) end, sets:new(), AccMap)
        end,
        maps:new(),
        Purchases
    ),

    PairCountsMap = maps:fold(
        fun(_User, ProductsSet, AccPairCountsMap) ->
            SortedProducts = lists:sort(sets:to_list(ProductsSet)),

            Pairs = generate_pairs(SortedProducts),

            lists:foldl(
                fun(Pair, InnerAccPairCountsMap) ->
                    maps:update_with(Pair, fun(Count) -> Count + 1 end, 1, InnerAccPairCountsMap)
                end,
                AccPairCountsMap,
                Pairs
            )
        end,
        maps:new(),
        UserProductsMap
    ),

    maps:fold(
        fun({P1, P2}, Count, AccList) ->
            [[P1, P2, Count] | AccList]
        end,
        [],
        PairCountsMap
    ).

generate_pairs(ProductsList) ->
    case ProductsList of
        [] -> [];
        [_] -> [];
        [H | T] ->
            PairsWithH = [{H, P} || P <- T],
            PairsWithH ++ generate_pairs(T)
    end.