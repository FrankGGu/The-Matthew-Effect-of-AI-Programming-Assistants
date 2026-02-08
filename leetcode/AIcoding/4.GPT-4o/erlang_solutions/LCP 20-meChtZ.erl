-module(solution).
-export([numBusesToDestination/3]).

numBusesToDestination(Start, Target, Routes) ->
    case Start =:= Target of
        true -> 0;
        false -> bfs(Start, Target, Routes)
    end.

bfs(Start, Target, Routes) ->
    Queue = [{Start, 0}],
    VisitedStops = sets:empty(),
    VisitedRoutes = sets:empty(),
    bfs_helper(Queue, VisitedStops, VisitedRoutes, Target).

bfs_helper([], _, _, _) ->
    -1;
bfs_helper([{CurrentStop, Buses} | Rest], VisitedStops, VisitedRoutes, Target) ->
    if
        CurrentStop =:= Target -> Buses;
        true ->
            NewVisitedStops = sets:add(CurrentStop, VisitedStops),
            NewRoutes = find_routes(CurrentStop, Routes, VisitedRoutes),
            NewQueue = lists:foldl(fun(Route, Acc) -> 
                lists:foldl(fun(Stop, Acc1) -> 
                    if 
                        sets:is_element(Stop, NewVisitedStops) -> Acc1; 
                        true -> [{Stop, Buses + 1} | Acc1] 
                    end 
                end, Acc, Route) 
            end, Rest, NewRoutes),
            bfs_helper(NewQueue, NewVisitedStops, sets:add_list(NewRoutes, VisitedRoutes), Target)
    end.

find_routes(Stop, Routes, VisitedRoutes) ->
    lists:filter(fun(Route) -> 
        not(sets:is_element(Route, VisitedRoutes)) 
    end, lists:filter(fun(Route) -> 
        lists:member(Stop, Route) 
    end, Routes)).