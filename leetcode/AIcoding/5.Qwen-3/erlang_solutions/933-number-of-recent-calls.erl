-module(recent_calls).
-export([ping/1]).

ping(Timeout) ->
    erlang:register(ping, self()),
    receive
        {call, Time} ->
            Now = erlang:monotonic_time(millisecond),
            case Now - Time of
                Diff when Diff > Timeout ->
                    ok;
                _ ->
                    erlang:send(self(), {call, Time})
            end,
            erlang:send(self(), {count}),
            receive
                {count, Count} -> Count
            after 0 -> 0
            end
    end.

ping(Timeout, Calls) ->
    Now = erlang:monotonic_time(millisecond),
    NewCalls = lists:filter(fun({T}) -> Now - T =< Timeout end, Calls),
    [Now | NewCalls],
    length(NewCalls).