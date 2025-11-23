-module(solution).
-export([hasGroupsSizeX/1]).

hasGroupsSizeX(Deck) ->
    FreqMap = count_frequencies(Deck),
    Frequencies = maps:values(FreqMap),

    case Frequencies of
        [] ->
            false;
        _ ->
            CommonDivisor = lists:foldl(fun(X, Acc) -> math:gcd(X, Acc) end, 0, Frequencies),
            CommonDivisor >= 2
    end.

count_frequencies(Deck) ->
    lists:foldl(fun(Card, AccMap) ->
        maps:update_with(Card, fun(Count) -> Count + 1 end, 1, AccMap)
    end, maps:new(), Deck).