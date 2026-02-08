-module(solution).
-export([get_order/2]).

get_order(servers, tasks) ->
    TaskList = lists:zip(tasks, lists:seq(0, length(tasks) - 1)),
    SortedTasks = lists:sort(fun({{D1, T1}, _}, {{D2, T2}, _}) -> D1 < D2 orelse (D1 =:= D2 andalso T1 < T2) end, TaskList),
    process_tasks(servers, SortedTasks, 0, [], []).

process_tasks(_, [], _, Result, _) -> lists:reverse(Result);
process_tasks(Servers, Tasks, Time, Result, Queue) ->
    NewQueue = lists:sort(fun({{_, T1}, _}, {{_, T2}, _}) -> T1 < T2 end, Queue),
    case lists:filter(fun({{D, _}, _}) -> D =< Time end, Tasks) of
        [] -> 
            case NewQueue of
                [] -> process_tasks(Servers, Tasks, Time + 1, Result, []);
                [{Task, Index} | Rest] -> 
                    process_tasks(Servers, Tasks, Time + 1, [Index | Result], Rest);
            end;
        ReadyTasks ->
            {NextTask, Index} = hd(ReadyTasks),
            NewTasks = tl(ReadyTasks) ++ Tasks,
            NewQueue1 = [{NextTask, Index} | NewQueue],
            process_tasks(Servers, NewTasks, Time, Result, NewQueue1)
    end.