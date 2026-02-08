-module(solution).
-export([max_value/2]).

max_value(Ids, S) ->
    max_value(Ids, S, 0, 0, []).

max_value([], _, _, _, Acc) ->
    lists:reverse(Acc);
max_value([Id | Rest], S, Count, CurrentSum, Acc) ->
    NewCount = Count + 1,
    NewCurrentSum = CurrentSum + Id,
    case NewCount of
        1 ->
            max_value(Rest, S, NewCount, NewCurrentSum, [NewCurrentSum | Acc]);
        _ ->
            if
                NewCurrentSum > S ->
                    max_value(Rest, S, 0, 0, Acc);
                true ->
                    max_value(Rest, S, NewCount, NewCurrentSum, [NewCurrentSum | Acc])
            end
    end.