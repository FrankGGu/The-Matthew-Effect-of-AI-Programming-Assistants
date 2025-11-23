-module(solution).
-export([analyze_hierarchy/1]).

analyze_hierarchy(Employees) ->
    DirectReportsCountMap = lists:foldl(
        fun({_Id, _Name, ManagerId}, AccMap) ->
            if ManagerId =/= -1 ->
                maps:update_with(ManagerId, fun(Count) -> Count + 1 end, 1, AccMap);
            true ->
                AccMap
            end
        end,
        #{},
        Employees
    ),

    lists:map(
        fun({Id, _Name, _ManagerId}) ->
            Count = maps:get(Id, DirectReportsCountMap, 0),
            {Id, Count}
        end,
        Employees
    ).