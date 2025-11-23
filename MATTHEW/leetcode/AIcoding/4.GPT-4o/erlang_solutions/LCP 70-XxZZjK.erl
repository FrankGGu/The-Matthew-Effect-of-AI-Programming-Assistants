-module(solution).
-export([sand_management/1]).

sand_management(S) ->
    lists:sort(fun({X1, Y1}, {X2, Y2}) -> 
        case X1 < Y2 of
            true -> true;
            false -> case X2 < Y1 of
                true -> false;
                _ -> X1 < X2
            end
        end 
    end, S).