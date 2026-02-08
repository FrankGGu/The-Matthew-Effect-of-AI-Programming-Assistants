-module(solution).
-export([min_time/1]).

min_time(Files) ->
    lists:foldl(fun(File, Acc) -> 
        case Acc of 
            {TimeSum, Min} -> 
                {TimeSum + File, min(Min, File)} 
        end 
    end, {0, hd(Files)}, tl(Files)).