-module(time_needed_to_inform_all_employees).
-export([num_of_minutes/2]).

num_of_minutes(Manager, Employee) ->
    Graph = build_graph(Manager),
    inform_time(Graph, Employee).

build_graph(Manager) ->
    lists:foldl(fun({Employee, ManagerId}, Acc) ->
                    case maps:find(ManagerId, Acc) of
                        {ok, List} -> maps:put(ManagerId, [Employee | List], Acc);
                        _ -> maps:put(ManagerId, [Employee], Acc)
                    end
                end, maps:new(), Manager).

inform_time(Graph, Employee) ->
    inform_time(Graph, Employee, 0, #{}).

inform_time(_Graph, -1, Time, _Visited) ->
    Time;
inform_time(Graph, Employee, Time, Visited) ->
    case maps:find(Employee, Visited) of
        {ok, _} -> Time;
        _ ->
            NewVisited = maps:put(Employee, true, Visited),
            case maps:find(Employee, Graph) of
                {ok, Subordinates} ->
                    lists:foldl(fun(Sub, Acc) ->
                                    inform_time(Graph, Sub, Time + 1, NewVisited)
                                end, Time, Subordinates);
                _ ->
                    Time
            end
    end.