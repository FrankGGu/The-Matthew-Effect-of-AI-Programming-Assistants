-module(product_of_numbers).
-export([init/0, add/2, get_product/2]).

init() ->
    {[], []}.

add(Num, {Prefix, Suffix}) ->
    case Prefix of
        [] -> NewPrefix = [Num];
        [H|_] -> NewPrefix = [Num * H | Prefix]
    end,
    {NewPrefix, Suffix}.

get_product(K, {Prefix, Suffix}) ->
    case K =< length(Prefix) of
        true -> lists:nth(K, Prefix);
        false ->
            case Suffix of
                [] -> 0;
                _ ->
                    case length(Prefix) + length(Suffix) < K of
                        true -> 0;
                        false ->
                            Product = lists:foldl(fun(X, Acc) -> X * Acc end, 1, Suffix),
                            lists:nth(length(Prefix), Prefix) * Product
                    end
            end
    end.