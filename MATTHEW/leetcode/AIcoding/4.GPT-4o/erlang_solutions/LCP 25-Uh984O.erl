-module(solution).
-export([minimumTime/2]).

minimumTime(KeyPresses, TimeCosts) ->
    lists:foldl(fun({Key, Cost}, Acc) -> Acc + Cost * (lists:nth(Key, KeyPresses) - 1) end, 0, lists:zip(KeyPresses, TimeCosts)).