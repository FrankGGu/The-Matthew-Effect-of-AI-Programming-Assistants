-module(solution).
-export([dominant_index/1]).

dominant_index(Nums) ->
    Max = lists:max(Nums),
    Filtered = lists:filter(fun(X) -> X =/= Max end, Nums),
    case Filtered of
        [] -> 0;
        _ -> 
            SecondMax = lists:max(Filtered),
            if 
                Max >= 2 * SecondMax -> lists:find(fun(X) -> X =:= Max end, Nums);
                true -> -1
            end
    end.