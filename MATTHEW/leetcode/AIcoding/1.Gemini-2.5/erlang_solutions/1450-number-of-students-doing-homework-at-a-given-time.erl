-spec busy_students(StartTime :: [integer()], EndTime :: [integer()], QueryTime :: integer()) -> integer().
busy_students(StartTime, EndTime, QueryTime) ->
    Pairs = lists:zip(StartTime, EndTime),
    lists:foldl(fun({S, E}, Acc) ->
                        if S =< QueryTime, E >= QueryTime -> Acc + 1;
                           true -> Acc
                        end
                end, 0, Pairs).