-module(best_poker_hand).
-export([best_hand/1]).

best_hand(Hand) ->
    Counts = count_cards(Hand),
    SortedCounts = lists:sort(fun({_, A}, {_, B}) -> A >= B end, Counts),
    case SortedCounts of
        [{_, 5} | _] -> "Flush";
        [{_, 4} | _] -> "Four of a Kind";
        [{_, 3}, {_, 2} | _] -> "Full House";
        [{_, 3} | _] -> "Three of a Kind";
        [{_, 2}, {_, 2} | _] -> "Two Pair";
        [{_, 2} | _] -> "One Pair";
        _ -> "High Card"
    end.

count_cards(Hand) ->
    Cards = string:split(Hand, " "),
    CountMap = maps:new(),
    lists:foldl(fun(Card, Acc) ->
        Key = lists:nth(0, string:split(Card, "")),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, CountMap, Cards).