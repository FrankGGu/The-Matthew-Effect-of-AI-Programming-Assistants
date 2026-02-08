-module(solution).
-export([deck_reveal_in_increasing_order/1]).

deck_reveal_in_increasing_order(Deck) ->
    SortedDeck = lists:sort(Deck),
    N = length(SortedDeck),
    Result = lists:duplicate(N, 0),
    Position = queue:from_list(lists:seq(1, N)),
    decks(SortedDeck, Position, Result).

decks([], _, Result) -> 
    Result;
decks([H | T], Position, Result) ->
    {Pos, NewPosition} = queue:out(Position),
    NewResult = lists:replace(Result, Pos, H),
    case queue:out(NewPosition) of
        {value, NextPos} -> 
            decks(T, queue:in(NextPos, NewPosition), NewResult);
        _ -> 
            NewResult
    end.