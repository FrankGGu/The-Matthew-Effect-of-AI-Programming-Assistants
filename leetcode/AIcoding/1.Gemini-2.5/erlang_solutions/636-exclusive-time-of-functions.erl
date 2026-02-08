-module(solution).
-export([exclusive_time/2]).

exclusive_time(N, Logs) ->
    InitialAns = array:new([{size, N}, {fixed, true}, {default, 0}]),
    process_logs(Logs, [], 0, InitialAns).

process_logs([], _Stack, _PrevTime, AnsArray) ->
    array:to_list(AnsArray);

process_logs([LogStr | RestLogs], Stack, PrevTime, AnsArray) ->
    [IdStr, TypeStr, TimeStr] = string:split(LogStr, ":", all),
    Id = list_to_integer(IdStr),
    Type = list_to_atom(TypeStr),
    Time = list_to_integer(TimeStr),

    case Type of
        start ->
            NewAnsArray =
                case Stack of
                    [{TopId, _TopStartTime} | _] ->
                        CurrentDuration = Time - PrevTime,
                        array:set(TopId, array:get(TopId, AnsArray) + CurrentDuration, AnsArray);
                    [] ->
                        AnsArray
                end,
            NewStack = [{Id, Time} | Stack],
            NewPrevTime = Time,
            process_logs(RestLogs, NewStack, NewPrevTime, NewAnsArray);

        end ->
            [{TopId, _TopStartTime} | RestStack] = Stack,
            Duration = Time - PrevTime + 1,
            NewAnsArray = array:set(TopId, array:get(TopId, AnsArray) + Duration, AnsArray),
            NewPrevTime = Time + 1,
            process_logs(RestLogs, RestStack, NewPrevTime, NewAnsArray)
    end.