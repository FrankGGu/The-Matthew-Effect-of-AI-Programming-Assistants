-module(runes).
-export([numRookQueries/1]).

numRookQueries(Rooks) ->
    Rows = lists:foldl(fun({X, Y}, Acc) -> 
        maps:update(X, [Y | maps:get(X, Acc, [])], Acc)
    end, #{}, Rooks),
    Cols = lists:foldl(fun({X, Y}, Acc) -> 
        maps:update(Y, [X | maps:get(Y, Acc, [])], Acc)
    end, #{}, Rooks),
    lists:map(fun({X, Y}) -> 
        Length = length(maps:get(X, Rows)) + length(maps:get(Y, Cols)) - 1,
        if
            Length > 0 -> 1;
            true -> 0
        end
    end, Rooks).