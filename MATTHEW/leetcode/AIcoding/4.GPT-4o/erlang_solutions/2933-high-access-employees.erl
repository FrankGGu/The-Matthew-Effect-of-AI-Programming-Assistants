-module(solution).
-export([high_access_employees/2]).

high_access_employees(N, Logs) ->
    Logs1 = lists:map(fun({Id, Time}) -> {Id, lists:sum(Time)} end, Logs),
    M = lists:max(lists:map(fun({_, T}) -> T end, Logs1)),
    lists:filter(fun({_, T}) -> T == M end, Logs1).