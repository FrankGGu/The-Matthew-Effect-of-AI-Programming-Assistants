-module(solution).
-export([num_darts_in_circle/3]).

num_darts_in_circle(N, R, darts) when is_list(darts) ->
    lists:foldl(fun({X, Y}, Acc) ->
        if
            X * X + Y * Y =< R * R -> Acc + 1;
            true -> Acc
        end
    end, 0, darts).