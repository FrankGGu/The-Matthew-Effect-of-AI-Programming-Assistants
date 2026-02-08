-module(solution).
-export([find_closest_number/1]).

find_closest_number(List) ->
    lists:foldl(fun(X, Acc) ->
        case {X >= 0, Acc >= 0} of
            {true, true} -> 
                if 
                    abs(X) < abs(Acc) -> X; 
                    abs(X) > abs(Acc) -> Acc; 
                    true -> max(X, Acc) 
                end;
            {true, false} -> X;
            {false, true} -> Acc;
            {false, false} -> 
                if 
                    abs(X) < abs(Acc) -> X; 
                    abs(X) > abs(Acc) -> Acc; 
                    true -> max(X, Acc) 
                end
        end
    end, hd(List), List).