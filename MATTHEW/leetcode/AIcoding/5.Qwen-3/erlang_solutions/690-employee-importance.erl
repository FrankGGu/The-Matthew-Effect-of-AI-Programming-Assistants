-module(employee_importance).
-export([getImportance/2]).

-record(employee, {id, importance, subordinates}).

getImportance(Employees, Id) ->
    EmployeeMap = maps:from_list([ {E#employee.id, E} || E <- Employees ]),
    getImportanceHelper(EmployeeMap, Id).

getImportanceHelper(EmployeeMap, Id) ->
    Employee = maps:get(Id, EmployeeMap),
    Importance = Employee#employee.importance,
    Subordinates = Employee#employee.subordinates,
    lists:sum([ Importance | [ getImportanceHelper(EmployeeMap, SubId) || SubId <- Subordinates ] ]).