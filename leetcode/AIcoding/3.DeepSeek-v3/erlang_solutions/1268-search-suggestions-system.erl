-module(solution).
-export([suggested_products/2]).

suggested_products(Products, SearchWord) ->
    Sorted = lists:sort(Products),
    suggested_products(Sorted, SearchWord, [], 1).

suggested_products(_, [], Acc, _) ->
    lists:reverse(Acc);
suggested_products(Products, [C | Rest], Acc, Len) ->
    Prefix = string:sub_string(SearchWord, 1, Len),
    Filtered = [P || P <- Products, string:sub_string(P, 1, Len) =:= Prefix],
    Suggestions = lists:sublist(Filtered, 3),
    suggested_products(Filtered, Rest, [Suggestions | Acc], Len + 1).