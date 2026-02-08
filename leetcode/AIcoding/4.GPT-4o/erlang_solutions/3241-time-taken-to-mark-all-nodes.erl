-module(solution).
-export([time_taken/2]).

time_taken(Tree, Time) ->
    time_taken(Tree, Time, 0).

time_taken([], _, Time) -> Time;
time_taken([{Node, Left, Right} | Rest], Time, Acc) ->
    NewAcc = Acc + Time,
    time_taken(Left, NewAcc, Time),
    time_taken(Right, NewAcc, Time),
    time_taken(Rest, Time, Acc).