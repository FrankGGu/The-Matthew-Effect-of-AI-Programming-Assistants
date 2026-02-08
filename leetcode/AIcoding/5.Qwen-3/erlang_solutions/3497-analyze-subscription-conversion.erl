-module(subscription_conversion).
-export([calculate_conversion_rate/1]).

calculate_conversion_rate(Events) ->
    {Subscribed, NotSubscribed} = lists:foldl(fun(Event, {S, NS}) ->
        case Event of
            <<"subscribe">> -> {S + 1, NS};
            _ -> {S, NS + 1}
        end
    end, {0, 0}, Events),
    if
        NotSubscribed == 0 -> 0.0;
        true -> (Subscribed / NotSubscribed) * 100.0
    end.