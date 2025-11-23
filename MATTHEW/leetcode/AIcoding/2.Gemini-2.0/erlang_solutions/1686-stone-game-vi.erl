-module(stone_game_vi).
-export([stone_game_vi/2]).

stone_game_vi(AliceValues, BobValues) ->
    N = length(AliceValues),
    IndexedValues = lists:zip(lists:seq(1, N), AliceValues, BobValues),
    SortedValues = lists:keysort(2, lists:map(fun({I, A, B}) -> {I, A + B, A, B} end, IndexedValues)),
    ReversedValues = lists:reverse(SortedValues),
    AliceScore = sum([A || {_, _, A, _} <- lists:nthtail(1, ReversedValues, 2)]),
    BobScore = sum([B || {_, _, _, B} <- lists:nthtail(2, ReversedValues, 2)]),
    case AliceScore > BobScore of
        true -> 1;
        false ->
            case AliceScore < BobScore of
                true -> -1;
                false -> 0
            end
    end.

sum(List) ->
    sum(List, 0).

sum([], Acc) ->
    Acc;
sum([H|T], Acc) ->
    sum(T, Acc + H).