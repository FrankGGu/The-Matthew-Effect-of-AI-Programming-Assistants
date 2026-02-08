-module(solution).
-export([minimize_max/1]).

minimize_max(A) ->
    Min = lists:min(A),
    Max = lists:max(A),
    minimize(Max, Min, A).

minimize(Max, Min, A) ->
    case Max - Min of
        0 -> Max;
        _ -> 
            Mid = (Max + Min) div 2,
            if 
                can_reduce(Mid, A) ->
                    minimize(Mid, Min, A);
                true ->
                    minimize(Max, Mid + 1, A)
            end
    end.

can_reduce(Mid, A) ->
    N = length(A),
    lists:foldl(fun(X, Acc) -> 
        case Acc of
            {Prev, Count} ->
                if 
                    Prev + Mid < X -> 
                        {X, Count + 1};
                    true -> 
                        {X, Count}
                end
        end 
    end, {hd(A), 0}, tl(A)) =< N.