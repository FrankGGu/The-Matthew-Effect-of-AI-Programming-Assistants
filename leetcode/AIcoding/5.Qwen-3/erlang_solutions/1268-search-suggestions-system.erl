-module(search_suggestions_system).
-export([suggestedProducts/2]).

suggestedProducts(Products, SearchWord) ->
    lists:foldl(fun(Char, Acc) ->
        case Acc of
            [] -> [];
            _ ->
                lists:sublist(
                    lists:sort(
                        lists:filter(
                            fun(Product) -> 
                                length(Product) >= length(Acc) andalso 
                                lists:prefix(lists:sublist(Acc, length(Acc)), Product)
                            end,
                            Products
                        )
                    ),
                    3
                )
        end ++ [Char]
    end, [], SearchWord).

lists:prefix(Prefix, List) ->
    lists:sublist(List, length(Prefix)) == Prefix.