-module(solution).
-export([deckRevealedIncreasing/1]).

deckRevealedIncreasing(Deck) ->
    N = length(Deck),
    SortedDeck = lists:sort(Deck),

    IndicesQueue = queue:from_list(lists:seq(0, N-1)),

    ResultArray = array:new([{size, N}, {fixed, true}]),

    fill_result(SortedDeck, IndicesQueue, ResultArray).

fill_result([], _IndicesQueue, ResultArray) ->
    array:to_list(ResultArray);
fill_result([Card|RestCards], IndicesQueue, ResultArray) ->
    {{value, Index}, Q1} = queue:out(IndicesQueue),

    NewResultArray = array:set(Index, Card, ResultArray),

    UpdatedIndicesQueue = 
        case queue:is_empty(Q1) of
            true ->
                Q1;
            false ->
                {{value, NextIndex}, Q2} = queue:out(Q1),
                queue:in(NextIndex, Q2)
        end,

    fill_result(RestCards, UpdatedIndicesQueue, NewResultArray).