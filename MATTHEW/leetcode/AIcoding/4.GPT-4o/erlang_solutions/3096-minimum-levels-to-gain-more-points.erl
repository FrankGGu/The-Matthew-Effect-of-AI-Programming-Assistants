-module(solution).
-export([min_levels/1]).

min_levels(Levels) ->
    lists:foldl(fun({_, Points}, Acc) -> 
        case Acc of 
            {MinLevels, MinPoints} when MinPoints < Points -> 
                {MinLevels + 1, Points};
            _ -> 
                Acc 
        end 
    end, {0, 0}, Levels).