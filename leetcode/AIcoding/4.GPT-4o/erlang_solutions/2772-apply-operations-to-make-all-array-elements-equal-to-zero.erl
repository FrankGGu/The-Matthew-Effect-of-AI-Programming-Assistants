-module(solution).
-export([apply_operations/1]).

apply_operations(Arr) ->
    NewArr = lists:map(fun(X) -> 
        case X of 
            0 -> 0; 
            _ -> X 
        end 
    end, Arr),
    lists:filter(fun(X) -> X =/= 0 end, NewArr).