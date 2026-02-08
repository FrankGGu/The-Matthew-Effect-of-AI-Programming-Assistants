-module(solution).
-export([abbreviate_product/2]).

abbreviate_product(N, K) ->
    Product = lists:foldl(fun(X, Acc) -> Acc * X end, 1, lists:seq(1, N)),
    Abbr = abbreviate(Product, K),
    Abbr.

abbreviate(Product, K) ->
    case integer_to_list(Product) of
        Str when length(Str) =< K -> Str;
        Str -> 
            Prefix = lists:sublist(Str, K),
            Suffix = length(Str) - K,
            Prefix ++ "..." ++ integer_to_list(Suffix)
    end.