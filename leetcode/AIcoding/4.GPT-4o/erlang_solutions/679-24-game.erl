-module(solution).
-export([judgePoint24/1]).

judgePoint24(Numbers) ->
    N = length(Numbers),
    case N of
        0 -> false;
        1 -> lists:element(1, Numbers) =:= 24.0;
        _ -> calculate(Numbers)
    end.

calculate(Numbers) ->
    lists:any(fun(X) -> 
        lists:any(fun(Y) -> 
            case combine(X, Y) of
                [] -> false;
                _ -> true
            end
        end, Numbers -- [X])
    end, Numbers).

combine(X, Y) ->
    [X + Y, X - Y, Y - X, X * Y, 
     if Y =/= 0 -> X / Y; true -> undefined end,
     if X =/= 0 -> Y / X; true -> undefined end].