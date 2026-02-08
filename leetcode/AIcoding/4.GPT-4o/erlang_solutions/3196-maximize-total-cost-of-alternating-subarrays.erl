-module(solution).
-export([max_alternating_sum/1]).

max_alternating_sum(List) ->
    MaxCost = lists:foldl(fun(X, Acc) -> 
        case Acc of 
            {Last, Sum, Cost} -> 
                case X > Last of 
                    true -> {X, Sum + X, Cost + Sum + X};
                    false -> {X, Sum + X, Cost}
                end
            _ -> {X, X, X}
        end 
    end, {0, 0, 0}, List),
    element(3, MaxCost).