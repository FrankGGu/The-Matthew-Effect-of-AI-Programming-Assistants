-module(count_zero_request_servers).
-export([countServers/1]).

countServers(Servers) ->
    Count = 0,
    countServers(Servers, Count).

countServers([], Count) ->
    Count;
countServers([Server | Rest], Count) ->
    [_, _, Requests] = Server,
    if
        Requests == 0 ->
            countServers(Rest, Count + 1);
        true ->
            countServers(Rest, Count)
    end.