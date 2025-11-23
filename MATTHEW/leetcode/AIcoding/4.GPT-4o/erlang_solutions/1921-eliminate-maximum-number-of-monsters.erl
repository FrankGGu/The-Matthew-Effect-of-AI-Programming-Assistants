-module(solution).
-export([eliminateMaximum/1]).

eliminateMaximum(Monsters) ->
    Sorted = lists:sort(fun({T1, _}, {T2, _}) -> T1 < T2 end, Monsters),
    eliminate(Sorted, 0, 0).

eliminate([], _, _) -> 0;
eliminate([{T, _} | Rest], Time, Count) ->
    if
        T > Time -> 
            eliminate(Rest, Time + 1, Count + 1);
        true -> 
            Count
    end.