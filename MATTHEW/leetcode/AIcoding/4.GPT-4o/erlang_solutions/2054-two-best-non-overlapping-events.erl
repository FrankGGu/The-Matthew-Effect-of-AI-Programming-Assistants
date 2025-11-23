-module(solution).
-export([maxTwoEvents/1]).

maxTwoEvents(Events) ->
    SortedEvents = lists:sort(fun({Start1, End1, _}, {Start2, End2, _}) -> Start1 < Start2 end, Events),
    MaxEnd = lists:foldl(fun({_, End, Value}, Acc) -> max(Acc, Value) end, 0, SortedEvents),
    max_two_events(SortedEvents, MaxEnd, 0).

max_two_events([], _, Acc) -> Acc;
max_two_events([{Start, End, Value} | Rest], MaxEnd, Acc) ->
    MaxValue = lists:foldl(fun({_, End2, Value2}, Acc2) -> 
                                if 
                                    End2 < Start -> max(Acc2, Value2); 
                                    true -> Acc2 
                                end 
                            end, Acc, Rest),
    max_two_events(Rest, MaxEnd, max(Acc, Value + MaxValue)).