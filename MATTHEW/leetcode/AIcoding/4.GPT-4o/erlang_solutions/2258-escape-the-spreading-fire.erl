-module(solution).
-export([maximum_minutes/3]).

maximum_minutes(R, C, T) ->
    FireTime = fire_time(R, C, T),
    case FireTime of
        {_, MaxTime} when MaxTime > T -> 0;
        {_, MaxTime} when MaxTime =:= T -> 1;
        {_, MaxTime} -> 2
    end.

fire_time(R, C, T) ->
    FireMap = lists:duplicate(R, lists:duplicate(C, -1)),
    FireSpread = [{X, Y, 0} || X <- lists:seq(0, R-1), Y <- lists:seq(0, C-1), lists:element(Y + 1, lists:element(X + 1, FireMap)) =:= 1],
    FireTime = fire_spread(FireSpread, FireMap),
    MaxTime = lists:max([Time || {_, _, Time} <- FireTime]),
    {FireTime, MaxTime}.

fire_spread([], FireMap) -> FireMap;
fire_spread([{X, Y, Time} | Rest], FireMap) ->
    NewTime = Time + 1,
    FireMap1 = update_fire_map(X + 1, Y, NewTime, FireMap),
    FireMap2 = update_fire_map(X - 1, Y, NewTime, FireMap1),
    FireMap3 = update_fire_map(X, Y + 1, NewTime, FireMap2),
    FireMap4 = update_fire_map(X, Y - 1, NewTime, FireMap3),
    fire_spread(Rest, FireMap4).

update_fire_map(X, Y, Time, FireMap) when X < 0; X >= length(FireMap); Y < 0; Y >= length(hd(FireMap)) -> FireMap;
update_fire_map(X, Y, Time, FireMap) ->
    case lists:element(Y + 1, lists:element(X + 1, FireMap)) of
        -1 -> lists:replace(Y + 1, lists:replace(X + 1, Time, FireMap), FireMap);
        _ -> FireMap
    end.