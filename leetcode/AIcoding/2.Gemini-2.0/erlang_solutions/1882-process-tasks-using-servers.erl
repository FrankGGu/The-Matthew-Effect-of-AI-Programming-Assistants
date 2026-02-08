-module(process_tasks).
-export([assign_tasks/2]).

assign_tasks(Servers, Tasks) ->
    assign_tasks_helper(Servers, Tasks, [], 0).

assign_tasks_helper(_, [], Acc, _) ->
    lists:reverse(Acc);
assign_tasks_helper(Servers, [Task | RestTasks], Acc, Time) ->
    AvailableServers = find_available_servers(Servers, Time),
    case AvailableServers of
        [] ->
            NextAvailableTime = find_next_available_time(Servers),
            assign_tasks_helper(Servers, [Task | RestTasks], Acc, NextAvailableTime);
        _ ->
            {ServerIndex, _} = lists:min([{Index, Weight} || {Index, {Weight, _}} <- lists:zip(lists:seq(1, length(AvailableServers)), AvailableServers)]),
            RealIndex = lists:nth(ServerIndex, [Index || {Index, {_, _}} <- lists:zip(lists:seq(1, length(Servers)), Servers), lists:member({Index, {_, _}}, lists:zip(lists:seq(1, length(AvailableServers)), AvailableServers))]),
            {Weight, AvailableTime} = lists:nth(RealIndex, Servers),
            NewServers = lists:replace(RealIndex - 1, {Weight, Time + Task}, Servers),
            assign_tasks_helper(NewServers, RestTasks, [RealIndex | Acc], Time + Task)
    end.

find_available_servers(Servers, Time) ->
    [{Index, {Weight, AvailableTime}} || {Index, {Weight, AvailableTime}} <- lists:zip(lists:seq(1, length(Servers)), Servers), AvailableTime =< Time].

find_next_available_time(Servers) ->
    lists:min([AvailableTime || {_, AvailableTime} <- Servers]).