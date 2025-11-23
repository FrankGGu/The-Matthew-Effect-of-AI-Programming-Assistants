-module(lock_breaker).
-export([min_time/1]).

min_time(Locks) ->
    min_time(Locks, 0).

min_time([], _Time) ->
    0;
min_time([Lock | Rest], Time) ->
    {_, _, _, _} = Lock,
    Case = case Lock of
        {A, B, C, D} when A == B andalso B == C andalso C == D -> 1;
        {A, B, C, D} when A == B andalso C == D -> 2;
        {A, B, C, D} when A == C andalso B == D -> 3;
        {A, B, C, D} when A == D andalso B == C -> 4;
        {A, B, C, D} when A == B or B == C or C == D -> 5;
        _ -> 6
    end,
    Time + Case + min_time(Rest, Time + Case).