-module(solution).
-export([employee_importance/2]).

employee_importance(Employees, Id) ->
    EmployeeMap = lists:foldl(fun(Emp, Acc) ->
                                  maps:put(maps:get(id, Emp), Emp, Acc)
                              end, #{}, Employees),
    dfs(EmployeeMap, Id).

dfs(EmployeeMap, CurrentId) ->
    case maps:find(CurrentId, EmployeeMap) of
        {ok, #{importance := Importance, subordinates := Subordinates}} ->
            CurrentImportance = Importance,
            SubordinatesImportance = lists:foldl(fun(SubordinateId, Acc) ->
                                                     Acc + dfs(EmployeeMap, SubordinateId)
                                                 end, 0, Subordinates),
            CurrentImportance + SubordinatesImportance;
        _ ->
            0
    end.