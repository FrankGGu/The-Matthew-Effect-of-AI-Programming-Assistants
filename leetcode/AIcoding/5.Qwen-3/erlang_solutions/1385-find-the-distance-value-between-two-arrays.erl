-module(solution).
-export([find_the_distance_value/2]).

find_the_distance_value(Left, Right) ->
    lists:foldl(fun(X, Acc) ->
        case lists:all(fun(Y) -> abs(X - Y) > Acc end, Right) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Left).