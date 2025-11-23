-module(solution).
-export([count_servers/3]).

count_servers(N, Logs, X, Queries) ->
    Servers = lists:seq(1, N),
    LogMap = lists:foldl(fun([time, server], Acc) ->
                            maps:update_with(server, fun(Times) -> [time | Times] end, [time], Acc)
                         end, #{}, Logs),
    lists:map(fun(Query) ->
                Start = Query - X,
                End = Query,
                lists:foldl(fun(Server, Count) ->
                              case maps:get(Server, LogMap, []) of
                                  [] -> Count + 1;
                                  Times ->
                                      Filtered = lists:filter(fun(T) -> T >= Start andalso T =< End end, Times),
                                      case Filtered of
                                          [] -> Count + 1;
                                          _ -> Count
                                      end
                              end
                           end, 0, Servers)
              end, Queries).