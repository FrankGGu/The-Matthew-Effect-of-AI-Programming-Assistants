-module(solution).
-export([maximum_invitations/1]).

maximum_invitations(Employees) ->
    MaxEmployees = length(Employees),
    Graph = build_graph(Employees, MaxEmployees),
    dfs(Graph, MaxEmployees).

build_graph(Employees, MaxEmployees) ->
    lists:foldl(fun({X, Y}, Acc) ->
        lists:map(fun(X) -> 
            {X, lists:filter(fun(Y) -> Y =/= X end, Acc)} 
        end, employees(X, Y, Acc))
    end, lists:duplicate(MaxEmployees, []), Employees).

employees(X, Y, Acc) ->
    case lists:nth(X + 1, Acc) of
        [] -> [Y];
        _ -> lists:append([Y], Acc)
    end.

dfs(Graph, MaxEmployees) ->
    lists:max(lists:map(fun(X) -> length(lists:nth(X + 1, Graph)) end, lists:seq(0, MaxEmployees - 1))).