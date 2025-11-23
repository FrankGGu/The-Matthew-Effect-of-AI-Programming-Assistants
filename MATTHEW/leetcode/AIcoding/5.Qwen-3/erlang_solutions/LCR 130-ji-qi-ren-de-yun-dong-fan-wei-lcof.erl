-module(clutter).
-export([sort_clothes/1]).

sort_clothes(Clothes) ->
    sort_clothes(Clothes, []).

sort_clothes([], Acc) ->
    lists:reverse(Acc);
sort_clothes([H | T], Acc) ->
    sort_clothes(T, [H | Acc]).