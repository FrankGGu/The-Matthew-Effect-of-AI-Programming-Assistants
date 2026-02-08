-spec task_scheduler_ii(Tasks :: [integer()], Space :: integer()) -> integer().
task_scheduler_ii(Tasks, Space) ->
    solve(Tasks, Space, maps:new(), 0).

solve([], _, _, Day) -> Day;
solve([Task | Rest], Space, LastDay, Day) ->
    case maps:find(Task, LastDay) of
        {ok, PrevDay} when Day - PrevDay =< Space ->
            NewDay = PrevDay + Space + 1,
            solve(Rest, Space, maps:put(Task, NewDay, LastDay), NewDay);
        _ ->
            solve(Rest, Space, maps:put(Task, Day, LastDay), Day + 1)
    end.