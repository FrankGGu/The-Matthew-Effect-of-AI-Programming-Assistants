-module(solution).
-export([maxFruits/1]).

maxFruits(Fruits) ->
    maxFruits(Fruits, 0, 0, 0).

maxFruits([], _, Max, _) -> 
    Max;
maxFruits([H | T], CurrentCount, Max, Start) ->
    NewCount = CurrentCount + H,
    NewMax = max(NewCount, Max),
    if
        NewCount > 2 -> 
            maxFruits(T, NewCount - 1, NewMax, Start + 1);
        true -> 
            maxFruits(T, NewCount, NewMax, Start)
    end.