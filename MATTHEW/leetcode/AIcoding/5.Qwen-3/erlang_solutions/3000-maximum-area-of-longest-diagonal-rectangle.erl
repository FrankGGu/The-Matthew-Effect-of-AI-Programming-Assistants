-module(max_area_of_longest_diagonal_rectangle).
-export([area/1]).

area(Rects) ->
    lists:foldl(fun({X, Y}, {MaxDiag, MaxArea}) ->
        Diag = X * X + Y * Y,
        if
            Diag > MaxDiag ->
                {Diag, X * Y};
            Diag == MaxDiag ->
                max(MaxArea, X * Y);
            true ->
                {MaxDiag, MaxArea}
        end
    end, {0, 0}, Rects).