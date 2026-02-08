-module(max_running_time).
-export([max_run_time/2]).

max_run_time(N, Batteries) ->
    lists:sort(Batteries, fun(A, B) -> A < B end),
    sum_batteries(Batteries, 0),
    max_run_time_helper(N, Batteries, 0).

max_run_time_helper(N, Batteries, Sum) ->
    case Batteries of
        [] ->
            Sum div N;
        _ ->
            if length(Batteries) < N then
                Sum div N
            else
                Shortest_battery = lists:nth(1, Batteries),
                Rest_batteries = lists:sublist(Batteries, 2, length(Batteries) - 1),
                if Shortest_battery > (Sum div N) then
                    Sum div N
                else
                    max_run_time_helper(N, Rest_batteries, Sum - Shortest_battery)
                end
            end
    end.

sum_batteries([], Sum) ->
    Sum;
sum_batteries([H|T], Sum) ->
    sum_batteries(T, Sum + H).