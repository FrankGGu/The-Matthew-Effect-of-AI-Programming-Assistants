-module(solution).
-export([num_fireworks/1]).

num_fireworks(LaunchTimes) ->
    SortedTimes = lists:sort(LaunchTimes),
    MaxTime = lists:last(SortedTimes),
    Total = lists:foldl(fun (T, Acc) -> 
        if T < MaxTime div 2 -> 
            Acc + 2 
        else 
            Acc + 1 
        end 
    end, 0, SortedTimes),
    Total.