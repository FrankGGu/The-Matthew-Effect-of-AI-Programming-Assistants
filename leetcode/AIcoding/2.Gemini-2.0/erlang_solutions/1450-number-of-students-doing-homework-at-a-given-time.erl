-module(solution).
-export([busyStudent/3]).

busyStudent(StartTime, EndTime, QueryTime) ->
    lists:foldl(fun(Start, Acc) ->
                        if Start =< QueryTime ->
                            Acc + 1
                        else
                            Acc
                        end
                    end, 0, lists:zipwith(fun(S, E) ->
                                                if S =< QueryTime andalso E >= QueryTime ->
                                                    1
                                                else
                                                    0
                                                end
                                            end, StartTime, EndTime)).