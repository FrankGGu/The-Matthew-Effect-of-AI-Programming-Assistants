-module(solution).
-export([min_time/1]).

min_time(Points) ->
    lists:foldl(fun({X1, Y1}, {X0, Y0, Acc}) ->
        D1 = abs(X1 - X0),
        D2 = abs(Y1 - Y0),
        {X1, Y1, Acc + max(D1, D2)}
    end, {hd(Points)}, tl(Points)).