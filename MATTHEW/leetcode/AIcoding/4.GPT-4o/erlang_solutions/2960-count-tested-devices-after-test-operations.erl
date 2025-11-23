-module(solution).
-export([count_tested_devices/1]).

count_tested_devices(TestOperations) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, Acc) of
            true -> Acc;
            false -> [X | Acc]
        end
    end, [], TestOperations) 
    |> length.