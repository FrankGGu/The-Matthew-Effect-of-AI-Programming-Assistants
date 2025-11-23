-module(solution).
-export([count_days_without_meetings/1]).

count_days_without_meetings(Dates) ->
    DatesList = maps:to_list(Dates),
    {DaysWithoutMeetings, _} = lists:foldl(fun({Date, Meetings}, {Acc, Last}) ->
        case Meetings of
            [] -> 
                case Last of
                    undefined -> {Acc + 1, Date};
                    _ when Last < Date -> {Acc + 1, Date};
                    _ -> {Acc, Last}
                end;
            _ -> {Acc, Date}
        end
    end, {0, undefined}, DatesList),
    DaysWithoutMeetings.