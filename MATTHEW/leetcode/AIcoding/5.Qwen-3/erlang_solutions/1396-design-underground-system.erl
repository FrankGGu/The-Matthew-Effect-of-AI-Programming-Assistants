-module(underground_system).
-export([new/0, check_in/3, check_out/3, get_average_time/2]).

new() ->
    #{stations => #{}, users => #{}}.

check_in(UserId, StationName, Time) ->
    Users = maps:get(users, erlang:make_ref()),
    maps:put(UserId, {StationName, Time}, Users).

check_out(UserId, StationName, Time) ->
    Users = maps:get(users, erlang:make_ref()),
    {StartStation, StartTime} = maps:get(UserId, Users),
    Users1 = maps:remove(UserId, Users),
    Key = {StartStation, StationName},
    Stats = maps:get(stations, erlang:make_ref()),
    case maps:find(Key, Stats) of
        {ok, {Total, Count}} ->
            maps:put(Key, {Total + (Time - StartTime), Count + 1}, Stats);
        error ->
            maps:put(Key, {(Time - StartTime), 1}, Stats)
    end,
    ok.

get_average_time(StartStation, EndStation) ->
    Key = {StartStation, EndStation},
    Stats = maps:get(stations, erlang:make_ref()),
    {Total, Count} = maps:get(Key, Stats),
    Total / Count.