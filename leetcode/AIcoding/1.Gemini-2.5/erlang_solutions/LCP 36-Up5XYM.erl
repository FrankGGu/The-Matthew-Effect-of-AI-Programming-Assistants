-module(solution).
-export([hasGroupsSizeX/1]).

hasGroupsSizeX(Deck) ->
    CountsMap = lists:foldl(
        fun(Card, AccMap) ->
            maps:update_with(Card, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        maps:new(),
        Deck
    ),

    CardCounts = maps:values(CountsMap),

    case CardCounts of
        [] ->
            false;
        _ ->
            GCD = lists:foldl(fun(X, Acc) -> math:gcd(X, Acc) end, hd(CardCounts), tl(CardCounts)),
            GCD >= 2
    end.