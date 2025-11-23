-module(solution).
-export([distribute_candies/2]).

distribute_candies(N, K) ->
    distribute(N, K, 1, []).

distribute(0, _K, _Current, Acc) -> 
    lists:reverse(Acc);
distribute(Remaining, K, Current, Acc) ->
    NewRemaining = Remaining - Current,
    NewCurrent = if NewRemaining < 0 -> 0; true -> min(Current + 1, NewRemaining) end,
    NewK = if NewRemaining < 0 -> K; true -> K rem NewRemaining end,
    distribute(NewRemaining, NewK, NewCurrent, [Current | Acc]).