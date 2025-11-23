-module(reachable_cell).
-export([is_reachable/3]).

is_reachable(X, Y, T) ->
    case {X, Y} of
        {0, 0} -> T == 0;
        {_, _} ->
            Dist = abs(X) + abs(Y),
            T >= Dist andalso (Dist rem 2) == (T rem 2)
    end.