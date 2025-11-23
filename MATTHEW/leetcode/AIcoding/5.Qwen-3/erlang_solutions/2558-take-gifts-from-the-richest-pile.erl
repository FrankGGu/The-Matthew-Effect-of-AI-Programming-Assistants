-module(take_gifts_from_the_richest_pile).
-export([pick_gifts/1]).

pick_gifts(Piles) ->
    pick_gifts(Piles, 0).

pick_gifts([], Acc) ->
    Acc;
pick_gifts(Piles, Acc) ->
    {Max, Rest} = lists:split(1, lists:reverse(lists:sort(Piles))),
    NewPiles = [trunc(math:sqrt(Max)) | Rest],
    pick_gifts(NewPiles, Acc + 1).