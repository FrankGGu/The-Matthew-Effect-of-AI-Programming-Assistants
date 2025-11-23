-module(reveal_cards_in_increasing_order).
-export([deck_revealed_increasing/1]).

deck_revealed_increasing(Deck) ->
    Len = length(Deck),
    Indices = lists:seq(0, Len - 1),
    SortedDeck = lists:sort(Deck),
    Result = lists:duplicate(Len, 0),
    deck_revealed_increasing_helper(SortedDeck, Indices, Result).

deck_revealed_increasing_helper([], _, Result) ->
    Result;
deck_revealed_increasing_helper([H|T], [Index|RestIndices], Result) ->
    NewResult = lists:nth_replace(Index + 1, H, Result),
    case RestIndices of
        [] ->
            deck_revealed_increasing_helper(T, [], NewResult);
        _ ->
            NewIndices = RestIndices ++ [lists:nth(1, RestIndices)],
            deck_revealed_increasing_helper(T, lists:sublist(NewIndices, 2, length(NewIndices) - 1), NewResult)
    end.