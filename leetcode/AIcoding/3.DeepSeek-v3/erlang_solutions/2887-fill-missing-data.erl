-module(solution).
-export([fill_missing/1]).

fill_missing(Products) ->
    fill_missing(Products, undefined, []).

fill_missing([], _, Acc) ->
    lists:reverse(Acc);
fill_missing([#{<<"quantity">> := null} = Product | Rest], LastValid, Acc) ->
    Filled = Product#{<<"quantity">> => LastValid},
    fill_missing(Rest, LastValid, [Filled | Acc]);
fill_missing([#{<<"quantity">> := Q} = Product | Rest], _, Acc) ->
    fill_missing(Rest, Q, [Product | Acc]);
fill_missing([Product | Rest], LastValid, Acc) ->
    fill_missing(Rest, LastValid, [Product | Acc]).