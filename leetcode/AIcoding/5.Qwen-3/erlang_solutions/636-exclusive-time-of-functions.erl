-module(exclusive_time_of_functions).
-export([exclusive_time/1]).

exclusive_time(Instructions) ->
    N = length(Instructions),
    Time = lists:duplicate(N, 0),
    Stack = [],
    {_, _, _} = lists:foldl(fun(Inst, {Time, Stack, LastTime}) ->
        [Id, Type] = parse_instruction(Inst),
        if
            Type == "start" ->
                case Stack of
                    [] ->
                        NewStack = [{Id, LastTime}],
                        {Time, NewStack, LastTime};
                    [{PrevId, PrevTime} | _] ->
                        NewTime = lists:sublist(Time, PrevId, 1) ++ [lists:nth(PrevId, Time) + (LastTime - PrevTime)],
                        NewStack = [{Id, LastTime} | Stack],
                        {NewTime, NewStack, LastTime}
                end;
            true ->
                [{PrevId, PrevTime} | Rest] = Stack,
                Duration = LastTime - PrevTime + 1,
                NewTime = lists:sublist(Time, PrevId, 1) ++ [lists:nth(PrevId, Time) + Duration],
                NewStack = Rest,
                {NewTime, NewStack, LastTime + 1}
        end
    end, {Time, [], 0}, Instructions),
    Time.

parse_instruction(Str) ->
    [IdStr, Type] = string:split(Str, ":"),
    Id = list_to_integer(IdStr),
    [Id, Type].