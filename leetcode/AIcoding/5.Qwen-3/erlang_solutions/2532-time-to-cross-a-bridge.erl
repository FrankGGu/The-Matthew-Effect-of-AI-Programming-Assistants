-module(solution).
-export([time_to_cross/1]).

time_to_cross(People) ->
    time_to_cross(People, 0, []).

time_to_cross([], Time, _) ->
    Time;
time_to_cross([A], Time, _) ->
    Time + A;
time_to_cross([A,B], Time, _) ->
    Time + erlang:min(A, B);
time_to_cross([A,B,C], Time, _) ->
    Time + A + B + C;
time_to_cross([A,B,C,D], Time, _) ->
    Time + erlang:min(A + B, A + D) + erlang:min(B + C, C + D);
time_to_cross(People, Time, Acc) ->
    [F, S | Rest] = lists:sort(People),
    Time1 = Time + F + S,
    [L, M | _] = lists:reverse(lists:sort(People)),
    Time2 = Time + L + M,
    case Time1 < Time2 of
        true ->
            time_to_cross(Rest, Time1, [F, S]);
        false ->
            time_to_cross(Rest, Time2, [L, M])
    end.