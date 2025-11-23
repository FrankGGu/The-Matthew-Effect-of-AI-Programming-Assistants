-module(solution).
-export([find_product_recommendations/1]).

find_product_recommendations(Products) ->
    Map = maps:from_list([{P, []} || P <- Products]),
    lists:foldl(fun(Product, Acc) ->
        lists:foldl(fun(Other, Acc2) ->
            case Product =/= Other of
                true ->
                maps:update_with(Product, fun(L) -> [Other | L] end, Acc2);
                false ->
                    Acc2
            end
        end, Acc, Products)
    end, Map, Products).

find_product_recommendations(Products, Threshold) ->
    Map = find_product_recommendations(Products),
    maps:to_list(maps:filter(fun(_, V) -> length(V) >= Threshold end, Map)).