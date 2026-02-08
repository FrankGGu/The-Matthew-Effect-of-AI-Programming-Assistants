-module(traffic_light).
-export([solve/1]).

solve(TrafficLight) ->
    solve(TrafficLight, 0).

solve([], _Time) ->
    0;
solve([H | T], Time) ->
    case H of
        'red' ->
            solve(T, Time + 1);
        'green' ->
            solve(T, Time + 1);
        'yellow' ->
            solve(T, Time + 1)
    end.