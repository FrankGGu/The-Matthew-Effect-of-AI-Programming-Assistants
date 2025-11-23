-module(solution).
-export([max_free_time/1]).

max_free_time(Meetings) ->
    SortedMeetings = lists:sort(fun({Start1, _}, {Start2, _}) -> Start1 < Start2 end, Meetings),
    FreeTimes = lists:foldl(fun({Start, End}, Acc) ->
        case Acc of
            [] -> [{Start, End}];
            [{PrevStart, PrevEnd} | Rest] ->
                if
                    PrevEnd < Start -> [{PrevStart, PrevEnd} | Acc];
                    true -> [{PrevStart, lists:max([PrevEnd, End])} | Rest]
                end
        end
    end, [], SortedMeetings),
    lists:map(fun({Start, End}) -> End - Start end, FreeTimes).