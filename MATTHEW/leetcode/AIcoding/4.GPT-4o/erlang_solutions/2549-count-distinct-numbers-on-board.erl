-module(solution).
-export([distinct_numbers/1]).

distinct_numbers(Queries) ->
    lists:map(fun(Query) ->
        Board = lists:foldl(fun({X, Y}, Acc) ->
            maps:update_with(X, fun(Val) -> Val + 1 end, 1, Acc)
        end, #{} , Query),
        maps:size(Board)
    end, Queries).