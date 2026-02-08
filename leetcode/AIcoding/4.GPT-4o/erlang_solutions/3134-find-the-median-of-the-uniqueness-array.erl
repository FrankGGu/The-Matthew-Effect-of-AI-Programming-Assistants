-module(solution).
-export([find_median/1]).

find_median(Numbers) ->
    UniqueNumbers = lists:usort(Numbers),
    Count = length(UniqueNumbers),
    case Count rem 2 of
        0 -> 
            Mid1 = UniqueNumbers!((Count div 2) - 1),
            Mid2 = UniqueNumbers!((Count div 2)),
            (Mid1 + Mid2) / 2.0;
        _ -> 
            UniqueNumbers!((Count div 2))
    end.