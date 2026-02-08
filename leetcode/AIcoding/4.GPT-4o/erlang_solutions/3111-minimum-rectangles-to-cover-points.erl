-module(solution).
-export([minimum_rectangles/1]).

minimum_rectangles(Points) ->
    Rectangles = lists:foldl(fun({X, Y}, Acc) ->
        case lists:keyfind({X, Y}, 1, Acc) of
            false -> [{X, Y, X, Y} | Acc];
            {X1, Y1, X2, Y2} -> [{X1, min(Y, Y1), max(X, X2), max(Y, Y2)} | lists:keydelete({X, Y}, 1, Acc)]
        end
    end, [], Points),
    length(Rectangles).