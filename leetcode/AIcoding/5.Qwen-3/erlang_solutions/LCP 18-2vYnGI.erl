-module(solve).
-export([max_satisfied/2]).

max_satisfied(Consumption, Customers) ->
    Max = lists:foldl(fun({S, T}, Acc) -> 
        case S >= 0 andalso T >= 0 of
            true -> 
                if T < 0 -> Acc;
                   true -> lists:sum([Acc, T]) end;
            false -> Acc
        end
    end, 0, Consumption),
    lists:foldl(fun({C, S, T}, Acc) -> 
        case C >= 0 andalso S >= 0 andalso T >= 0 of
            true -> 
                if S > T -> Acc;
                   true -> lists:sum([Acc, T]) end;
            false -> Acc
        end
    end, Max, Customers).