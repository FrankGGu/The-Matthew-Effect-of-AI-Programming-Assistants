-module(solution).
-export([min_transport_cost/2]).

min_transport_cost(Logs, D) ->
    Low = lists:max(Logs),
    High = lists:sum(Logs),
    binary_search(Low, High, Logs, D).

binary_search(Low, High, Logs, D) when Low < High ->
    Mid = Low + (High - Low) div 2,
    case check(Mid, Logs, D) of
        true -> binary_search(Low, Mid, Logs, D);
        false -> binary_search(Mid + 1, High, Logs, D)
    end;
binary_search(Low, _High, _Logs, _D) ->
    Low.

check(Capacity, Logs, D) ->
    check_recursive(Logs, Capacity, D, 1, 0).

check_recursive([], _Capacity, D, CurrentTrips, _CurrentWeight) ->
    CurrentTrips =< D;
check_recursive([Log | RestLogs], Capacity, D, CurrentTrips, CurrentWeight) ->
    case CurrentWeight + Log =< Capacity of
        true ->
            check_recursive(RestLogs, Capacity, D, CurrentTrips, CurrentWeight + Log);
        false ->
            NewTrips = CurrentTrips + 1,
            case NewTrips > D of
                true -> false;
                false -> check_recursive(RestLogs, Capacity, D, NewTrips, Log)
            end
    end.