-module(solution).
-export([min_time_to_brew/2]).

min_time_to_brew(Potions, N) ->
    lists:foldl(fun({Time, Amount}, Acc) ->
        TotalTime = Time * ceil(Amount / N),
        Acc + TotalTime
    end, 0, Potions).