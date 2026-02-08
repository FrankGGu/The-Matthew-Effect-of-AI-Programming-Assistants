-module(solution).
-export([minimum_card_pick/1]).

minimum_card_pick(Cards) ->
    Min = lists:foldl(fun({Card, Index}, Acc) ->
        case maps:find(Card, Acc) of
            {ok, LastIndex} -> min(LastIndex - Index + 1, Acc);
            _ -> Acc
        end
    end, infinity, lists:zip(Cards, lists:seq(1, length(Cards))),
    maps:from_list(lists:zip(Cards, lists:seq(1, length(Cards))))),
    if Min == infinity -> -1; true -> Min end.