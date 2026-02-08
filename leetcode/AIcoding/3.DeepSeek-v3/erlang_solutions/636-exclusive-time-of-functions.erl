-spec exclusive_time(N :: integer(), Logs :: [unicode:unicode_binary()]) -> [integer()].
exclusive_time(N, Logs) ->
    {Stack, Res, Prev} = lists:foldl(fun(Log, {S, R, P}) ->
        [IdStr, Action, TimeStr] = string:split(Log, ":", all),
        Id = list_to_integer(binary_to_list(IdStr)),
        Time = list_to_integer(binary_to_list(TimeStr)),
        case Action of
            <<"start">> ->
                NewR = case S of
                    [] -> R;
                    [{TopId, TopTime}|_] ->
                        lists:sublist(R, 1, TopId) ++ [lists:nth(TopId + 1, R) + Time - TopTime] ++ lists:nthtail(TopId + 1, R)
                end,
                {[{Id, Time}|S], NewR, Time};
            <<"end">> ->
                {[{_, TopTime}|Rest], _, _} = {S, R, P},
                NewR = lists:sublist(R, 1, Id) ++ [lists:nth(Id + 1, R) + Time - TopTime + 1] ++ lists:nthtail(Id + 1, R),
                {Rest, NewR, Time + 1}
        end
    end, {[], lists:duplicate(N, 0), 0}, Logs),
    Res.