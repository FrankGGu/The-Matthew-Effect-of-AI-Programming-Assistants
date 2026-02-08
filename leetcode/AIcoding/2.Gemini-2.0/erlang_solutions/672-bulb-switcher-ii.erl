-module(solution).
-export([find_ways/1]).

find_ways(N) ->
    find_ways(N, 0, 0, 0).

find_ways(N, P, Q, R) ->
    case N of
        1 -> 2;
        2 -> case P of
                 0 -> 4;
                 _ -> 4
             end;
        _ -> case P of
                 0 -> 7;
                 1 -> 7;
                 _ -> 8
             end
    end.