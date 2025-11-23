-module(recent_requests).
-export([ping/1]).

ping(Req) ->
    Now = erlang:monotonic_time(millisecond),
    [Requests | _] = erlang:process_info(self(), messages),
    [P | _] = lists:reverse(Requests),
    case P of
        {ping, Time} when Now - Time =< 3000 ->
            ok;
        _ ->
            erlang:send_after(3000, self(), {clear, Now})
    end,
    erlang:send(self(), {ping, Now}),
    Count = count_requests(Now),
    Count.

count_requests(Time) ->
    Requests = erlang:process_info(self(), messages),
    lists:foldl(fun({ping, T}, Acc) when T >= Time - 3000 -> Acc + 1; (_, Acc) -> Acc end, 0, lists:reverse(element(2, Requests))).