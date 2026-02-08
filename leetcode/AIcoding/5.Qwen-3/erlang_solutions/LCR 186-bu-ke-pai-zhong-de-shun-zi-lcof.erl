-module(solution).
-export([guess_dynastry/1]).

guess_dynastry(Items) ->
    guess_dynastry(Items, #{}).

guess_dynastry([], Acc) ->
    case maps:keys(Acc) of
        [D] -> D;
        _ -> "unknown"
    end;

guess_dynastry([Item | Rest], Acc) ->
    [Name, Dynasty] = string:split(Item, " "),
    case maps:find(Dynasty, Acc) of
        {ok, Count} ->
            guess_dynastry(Rest, maps:put(Dynasty, Count + 1, Acc));
        error ->
            guess_dynastry(Rest, maps:put(Dynasty, 1, Acc))
    end.