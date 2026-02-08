-spec busy_student(StartTime :: [integer()], EndTime :: [integer()], QueryTime :: integer()) -> integer().
busy_student(StartTime, EndTime, QueryTime) ->
    lists:foldl(fun({S, E}, Acc) ->
                    if
                        QueryTime >= S andalso QueryTime =< E -> Acc + 1;
                        true -> Acc
                    end
                end, 0, lists:zip(StartTime, EndTime)).