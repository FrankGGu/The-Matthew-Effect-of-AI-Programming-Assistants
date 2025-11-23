-module(solution).
-export([get_organization_info/2]).

get_organization_info(Employees, Id) ->
    {Name, Salary, Subordinates} = lists:keyfind(Id, 1, Employees),
    TotalSalary = Salary + lists:sum(lists:map(fun(S) -> get_total_salary(Employees, S) end, Subordinates)),
    {Name, TotalSalary, length(Subordinates)}.

get_total_salary(Employees, Id) ->
    case lists:keyfind(Id, 1, Employees) of
        {_, Salary, Subordinates} ->
            Salary + lists:sum(lists:map(fun(S) -> get_total_salary(Employees, S) end, Subordinates));
        _ ->
            0
    end.