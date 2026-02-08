-module(solution).
-export([minimum_lines/1]).

minimum_lines(Points) ->
    Sorted = lists:sort(fun({X1, Y1}, {X2, Y2}) -> X1 < X2 end, Points),
    minimum_lines(Sorted, 0, undefined).

minimum_lines([], Count, _) -> Count;
minimum_lines([_], Count, _) -> Count;
minimum_lines([{X1, Y1}, {X2, Y2} | Rest], Count, Prev) ->
    Slope = if
        X1 == X2 -> undefined;
        true -> (Y2 - Y1) / (X2 - X1)
    end,
    case Prev of
        undefined -> minimum_lines([{X2, Y2} | Rest], Count + 1, Slope);
        _ when Slope =:= Prev -> minimum_lines([{X2, Y2} | Rest], Count, Slope);
        _ -> minimum_lines([{X2, Y2} | Rest], Count + 1, Slope)
    end.