-module(solution).
-export([suggested_products/2]).

suggested_products(Products, SearchWord) ->
    SortedProducts = lists:sort(Products),
    generate_suggestions_helper(SearchWord, [], SortedProducts, []).

generate_suggestions_helper([], _CurrentPrefix, _SortedProducts, Acc) ->
    lists:reverse(Acc);
generate_suggestions_helper([H|T], CurrentPrefix, SortedProducts, Acc) ->
    NewPrefix = CurrentPrefix ++ [H],
    MatchingProducts = lists:filter(fun(P) -> string:prefix(NewPrefix, P) end, SortedProducts),
    Top3 = lists:sublist(MatchingProducts, 3),
    generate_suggestions_helper(T, NewPrefix, SortedProducts, [Top3 | Acc]).