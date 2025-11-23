-module(solution).
-export([minimum_cost/1]).

minimum_cost(S) ->
    Counts = lists:foldl(fun(C, Acc) -> 
        case maps:is_key(C, Acc) of
            true -> maps:update(C, fun(X) -> X + 1 end, Acc);
            false -> maps:put(C, 1, Acc)
        end
    end, #{}, S),
    Total = lists:sum(maps:to_list(Counts)),
    MaxCount = lists:max(maps:values(Counts)),
    Total - MaxCount.