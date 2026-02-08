-module(solve).
-export([remove_sticks/1]).

remove_sticks(Sticks) ->
    remove_sticks(Sticks, 0).

remove_sticks([], Acc) ->
    Acc;
remove_sticks(Sticks, Acc) ->
    Min = lists:min(Sticks),
    NewSticks = [X - Min || X <- Sticks, X > Min],
    remove_sticks(NewSticks, Acc + 1).