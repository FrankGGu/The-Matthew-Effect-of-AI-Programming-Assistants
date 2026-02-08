-module(solution).
-export([get_pairs/1]).

get_pairs(Orders) ->
    UserProducts = lists:foldl(fun([User, Product], Acc) ->
        case maps:find(User, Acc) of
            {ok, Products} -> maps:put(User, sets:add_element(Product, Products), Acc);
            error -> maps:put(User, sets:from_list([Product]), Acc)
        end
    end, maps:new(), Orders),

    ProductPairs = maps:fold(fun(_, Products, Acc) ->
        ProductsList = sets:to_list(Products),
        generate_pairs(ProductsList, Acc)
    end, maps:new(), UserProducts),

    SortedPairs = lists:sort(maps:to_list(ProductPairs)),
    [[P1, P2] || {[P1, P2], _} <- SortedPairs].

generate_pairs([], Acc) -> Acc;
generate_pairs([_], Acc) -> Acc;
generate_pairs([P | Rest], Acc) ->
    NewAcc = lists:foldl(fun(Q, InnerAcc) ->
        Pair = if P < Q -> [P, Q]; true -> [Q, P] end,
        case maps:find(Pair, InnerAcc) of
            {ok, Count} -> maps:put(Pair, Count + 1, InnerAcc);
            error -> maps:put(Pair, 1, InnerAcc)
        end
    end, Acc, Rest),
    generate_pairs(Rest, NewAcc).