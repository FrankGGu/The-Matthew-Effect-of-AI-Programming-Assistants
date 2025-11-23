-module(solution).
-export([analyze_hierarchy/1]).

analyze_hierarchy(Employees) ->
    Dict = lists:foldl(fun({Id, _, _}, Acc) -> dict:store(Id, 0, Acc) end, dict:new(), Employees),
    {Dict1, _} = lists:foldl(fun({Id, ManagerId, _}, {AccDict, AccCount}) ->
        case ManagerId of
            -1 -> {AccDict, AccCount};
            _ ->
                {Dict2, Count} = update_manager_count(ManagerId, AccDict, AccCount),
                {dict:store(Id, Count, Dict2), Count}
        end
    end, {Dict, 0}, Employees),
    lists:map(fun({Id, _, Value}) ->
        Count = dict:fetch(Id, Dict1),
        {Id, Value * Count}
    end, Employees).

update_manager_count(ManagerId, Dict, Count) ->
    case dict:find(ManagerId, Dict) of
        {ok, C} ->
            NewCount = C + 1,
            {dict:store(ManagerId, NewCount, Dict), NewCount};
        error ->
            {Dict, Count}
    end.