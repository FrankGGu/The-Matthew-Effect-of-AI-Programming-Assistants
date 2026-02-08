-module(solution).
-export([num_mice/1]).

num_mice(Remove) ->
    num_mice(Remove, 0, 0).

num_mice(Remove, Count, N) when Count >= Remove ->
    N;
num_mice(Remove, Count, N) ->
    NewN = N + 1,
    NewCount = Count + (if NewN rem 3 == 0 andalso NewN rem 5 == 0 -> 1; true -> 0 end),
    num_mice(Remove, NewCount, NewN).