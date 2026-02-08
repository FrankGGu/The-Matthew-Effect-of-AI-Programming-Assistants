-module(solution).
-export([is_good_array/1]).

is_good_array(Array) ->
    Counts = lists:foldl(fun(X, Acc) -> 
        case dict:find(X, Acc) of
            {ok, Count} -> dict:store(X, Count + 1, Acc);
            error -> dict:store(X, 1, Acc)
        end
    end, dict:new(), Array),
    lists:all(fun({_, Count}) -> Count rem 2 =:= 0 end, dict:to_list(Counts)).