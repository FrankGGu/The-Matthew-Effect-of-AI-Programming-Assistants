-module(solution).
-export([busyStudent/3]).

busyStudent(StartTimes, EndTimes, QueryTime) ->
    lists:foldl(fun({Start, End}, Acc) ->
        if 
            Start =< QueryTime andalso QueryTime =< End -> 
                Acc + 1;
            true -> 
                Acc 
        end
    end, 0, lists:zip(StartTimes, EndTimes)).