-module(analyze_organization_hierarchy).
-export([analyze_organization_hierarchy/1]).

analyze_organization_hierarchy(Employees) ->
  analyze_organization_hierarchy(Employees, []).

analyze_organization_hierarchy([], Acc) ->
  lists:reverse(Acc);
analyze_organization_hierarchy([Employee | Rest], Acc) ->
  analyze_organization_hierarchy(Rest, [process_employee(Employee) | Acc]).

process_employee({Id, Name, Department, ManagerId}) ->
  {Id, Name, Department, ManagerId}.