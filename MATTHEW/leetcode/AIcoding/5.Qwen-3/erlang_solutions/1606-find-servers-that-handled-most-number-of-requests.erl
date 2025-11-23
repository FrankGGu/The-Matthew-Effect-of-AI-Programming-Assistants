-module(servers_handled_most).
-export([find_servers/1]).

find_servers(Requests) ->
    find_servers(Requests, 0, 1, dict:new(), dict:new()).

find_servers([], _, _, ServerCounts, _) ->
    lists:sort(fun({A, B}, {C, D}) -> 
        if B == D -> A < C;
           true -> B > D
        end
    end, dict:to_list(ServerCounts));
find_servers([{Time, RequestId} | Rest], CurrentTime, ServerId, ServerCounts, ServerAvail) ->
    case dict:is_key(ServerId, ServerAvail) of
        true ->
            NewServerAvail = dict:remove(ServerId, ServerAvail),
            NewServerCounts = dict:update_counter(ServerId, 1, ServerCounts),
            find_servers(Rest, Time + 1, ServerId + 1, NewServerCounts, NewServerAvail);
        false ->
            case dict:is_key(ServerId, ServerAvail) of
                true ->
                    NewServerAvail = dict:remove(ServerId, ServerAvail),
                    NewServerCounts = dict:update_counter(ServerId, 1, ServerCounts),
                    find_servers(Rest, Time + 1, ServerId + 1, NewServerCounts, NewServerAvail);
                false ->
                    find_servers(Rest, Time + 1, ServerId + 1, ServerCounts, ServerAvail)
            end
    end.