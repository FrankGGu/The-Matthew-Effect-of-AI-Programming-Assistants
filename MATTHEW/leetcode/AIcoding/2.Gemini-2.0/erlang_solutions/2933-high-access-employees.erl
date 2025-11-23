-module(high_access_employees).
-export([high_access_employees/1]).

high_access_employees(Access_times) ->
  Employees = lists:usort(lists:keysort(0, Access_times)),
  EmployeesGrouped = group_by_employee(Employees, []),
  filter_high_access(EmployeesGrouped, []).

group_by_employee([], Acc) ->
  Acc;
group_by_employee([[Emp, Time] | Rest], Acc) ->
  {EmployeeAccessTimes, Remaining} = split_by_employee(Emp, [[Emp, Time] | Rest], []),
  group_by_employee(Remaining, [EmployeeAccessTimes | Acc]).

split_by_employee(_, [], Acc) ->
  {lists:reverse(Acc), []};
split_by_employee(Emp, [[CurrentEmp, CurrentTime] | Rest], Acc) ->
  if
    Emp == CurrentEmp ->
      split_by_employee(Emp, Rest, [[CurrentEmp, CurrentTime] | Acc]);
    true ->
      {lists:reverse(Acc), [[CurrentEmp, CurrentTime] | Rest]}
  end.

filter_high_access([], Acc) ->
  lists:usort(lists:reverse(Acc));
filter_high_access([EmployeeAccessTimes | Rest], Acc) ->
  if
    is_high_access(EmployeeAccessTimes) ->
      [[Emp, _] | _] = EmployeeAccessTimes,
      filter_high_access(Rest, [Emp | Acc]);
    true ->
      filter_high_access(Rest, Acc)
  end.

is_high_access(EmployeeAccessTimes) ->
  lists:any(fun(X) ->
              [[_, Time1] | _] = X,
              [_, Time2] = lists:nth(1, X),
              [_, Time3] = lists:nth(2, X),

              Minutes1 = convert_to_minutes(Time1),
              Minutes2 = convert_to_minutes(Time2),
              Minutes3 = convert_to_minutes(Time3),

              Minutes2 - Minutes1 < 60 andalso
              Minutes3 - Minutes1 < 60
            end, sliding_window(3, EmployeeAccessTimes)).

sliding_window(N, List) ->
  sliding_window(N, List, []).

sliding_window(_, [], Acc) ->
  lists:reverse(Acc);
sliding_window(N, List, Acc) when length(List) < N ->
  lists:reverse(Acc);
sliding_window(N, List, Acc) ->
  sliding_window(N, tl(List), [lists:sublist(List, N) | Acc]).

convert_to_minutes(Time) ->
  [H, M] = string:split(Time, ":", all),
  list_to_integer(H) * 60 + list_to_integer(M).