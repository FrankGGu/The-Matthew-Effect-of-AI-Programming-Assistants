-module(employee_importance).
-export([getImportance/1]).

getImportance(Employees) ->
    EmployeeMap = lists:foldl(
        fun(Emp, Acc) ->
            #{id := Id, importance := Importance, subordinates := Subordinates} = Emp,
            maps:put(Id, {Importance, Subordinates}, Acc)
        end,
        #{},
        Employees
    ),
    getImportance(1, EmployeeMap).

getImportance(Id, EmployeeMap) ->
    getImportance(Id, EmployeeMap, 0).

getImportance(Id, EmployeeMap, Acc) ->
    case maps:find(Id, EmployeeMap) of
        {ok, {Importance, Subordinates}} ->
            NewAcc = Acc + Importance,
            lists:foldl(
                fun(SubordinateId, CurrentAcc) ->
                    getImportance(SubordinateId, EmployeeMap, CurrentAcc)
                end,
                NewAcc,
                Subordinates
            );
        error ->
            Acc
    end.