-module(solution).
-export([get_importance/2]).

-record(employee, {id, importance, subordinates}).

get_importance(EmployeeList, EmployeeID) ->
    EmployeeMap = lists:foldl(fun(Emp, Acc) -> 
        maps:put(Emp#employee.id, Emp, Acc) 
    end, #{}, EmployeeList),
    get_importance_helper(EmployeeMap, EmployeeID).

get_importance_helper(EmployeeMap, EmployeeID) ->
    case maps:get(EmployeeID, EmployeeMap) of
        Employee ->
            Employee#importortance + 
            lists:sum(lists:map(fun(SubID) -> 
                get_importance_helper(EmployeeMap, SubID) 
            end, Employee#employee.subordinates));
        _ -> 
            0
    end.