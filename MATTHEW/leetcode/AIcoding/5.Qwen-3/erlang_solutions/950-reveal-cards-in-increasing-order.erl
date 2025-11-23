-module(reveal_cards_in_increasing_order).
-export([deck_revealed_increasing/1]).

deck_revealed_increasing(Deck) ->
    N = length(Deck),
    Indexes = lists:seq(0, N-1),
    SortedIndexes = lists:sort(fun(I1, I2) -> lists:nth(I1+1, Deck) < lists:nth(I2+1, Deck) end, Indexes),
    Result = lists:seq(0, N-1),
    reveal(Result, SortedIndexes, []).

reveal([], [], Acc) ->
    lists:reverse(Acc);
reveal([H|T], [I|Is], Acc) ->
    reveal(T, Is, [lists:nth(H+1, Deck) | Acc]).

-module(reveal_cards_in_increasing_order).
-export([deck_revealed_increasing/1]).

deck_revealed_increasing(Deck) ->
    N = length(Deck),
    Indexes = lists:seq(0, N-1),
    SortedIndexes = lists:sort(fun(I1, I2) -> lists:nth(I1+1, Deck) < lists:nth(I2+1, Deck) end, Indexes),
    Result = lists:seq(0, N-1),
    reveal(Result, SortedIndexes, Deck, []).

reveal([], [], _, Acc) ->
    lists:reverse(Acc);
reveal([H|T], [I|Is], Deck, Acc) ->
    reveal(T, Is, Deck, [lists:nth(I+1, Deck) | Acc]).