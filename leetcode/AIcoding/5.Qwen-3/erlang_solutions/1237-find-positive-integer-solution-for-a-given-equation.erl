-module(solution).
-export([findSolution/2]).

findSolution(C, D) ->
    findSolution(C, D, 1, 1000).

findSolution(_, _, X, Y) when X > 1000; Y < 1 ->
    [];
findSolution(C, D, X, Y) ->
    case C * X + D * Y of
        0 ->
            [ {X, Y} | findSolution(C, D, X + 1, Y - 1) ];
        _ ->
            findSolution(C, D, X + 1, Y - 1)
    end.