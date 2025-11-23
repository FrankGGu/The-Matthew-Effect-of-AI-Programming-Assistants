-module(solution).
-export([min_operations/2]).

min_operations(Array, K) ->
    Remainders = lists:map(fun(X) -> X rem K end, Array),
    Sum = lists:sum(Remainders),
    Divisor = Sum rem K,
    if 
        Divisor == 0 -> 0;
        true -> 
            Count = lists:filter(fun(X) -> X > 0 end, Remainders),
            case lists:sum(Count) of
                0 -> -1;
                _ -> 1
            end
    end.