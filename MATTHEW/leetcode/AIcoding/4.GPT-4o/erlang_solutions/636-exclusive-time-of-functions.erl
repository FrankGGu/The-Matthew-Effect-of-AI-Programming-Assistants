-module(solution).
-export([exclusive_time/2]).

exclusive_time(N, Logs) ->
    exclusive_time(N, Logs, [], 0, 0, []).

exclusive_time(_, [], _, _, _, Result) ->
    lists:reverse(Result);
exclusive_time(N, [Log | Rest], Stack, PrevTime, TotalTime, Result) ->
    [Id, Type, Time] = parse_log(Log),
    case Type of
        "start" ->
            If Stack == [] ->
                exclusive_time(N, Rest, [{Id, TotalTime + Time}], Time, TotalTime + Time, Result);
            _ ->
                [{TopId, StartTime} | _] = Stack,
                NewTime = TotalTime + Time - StartTime,
                exclusive_time(N, Rest, [{Id, TotalTime + Time} | Stack], Time, NewTime, Result ++ [TopId, NewTime])
        end;
        "end" ->
            [{TopId, StartTime} | RestStack] = Stack,
            NewTime = TotalTime + Time - StartTime + 1,
            exclusive_time(N, Rest, RestStack, Time, NewTime, Result ++ [TopId, NewTime])
    end.

parse_log(Log) ->
    [Id, Type, Time] = string:tokens(Log, ":"),
    {list_to_integer(Id), Type, list_to_integer(Time)}.