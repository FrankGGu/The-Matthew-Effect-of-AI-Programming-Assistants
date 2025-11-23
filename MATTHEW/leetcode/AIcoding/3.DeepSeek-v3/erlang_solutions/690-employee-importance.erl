-record(employee, {id, importance, subordinates}).

-spec get_importance(Employees :: [#employee{}], Id :: integer()) -> integer().
get_importance(Employees, Id) ->
    Map = lists:foldl(fun(#employee{id = Eid} = Emp, Acc) -> maps:put(Eid, Emp, Acc) end, #{}, Employees),
    get_importance_helper(Map, Id).

get_importance_helper(Map, Id) ->
    case maps:get(Id, Map) of
        #employee{importance = Imp, subordinates = Subs} ->
            Imp + lists:sum(lists:map(fun(SubId) -> get_importance_helper(Map, SubId) end, Subs))
    end.