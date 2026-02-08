-module(solution).
-export([findSafePath/2]).

findSafePath(Grid, K) ->
    Rows = length(Grid),
    Columns = length(hd(Grid)),
    Start = {0, 0},
    End = {Rows - 1, Columns - 1},
    case path_exists(Grid, Start, End, K, []) of
        true -> "YES";
        false -> "NO"
    end.

path_exists(_, {X, Y}, {X, Y}, 0, _) -> 
    true;
path_exists(Grid, {X, Y}, End, K, Visited) ->
    if
        X < 0 orelse X >= length(Grid) orelse 
        Y < 0 orelse Y >= length(hd(Grid)) orelse 
        lists:member({X, Y}, Visited) orelse 
        element(Y + 1, element(X + 1, Grid)) =:= 1 -> 
            false;
        true ->
            NewVisited = [{X, Y} | Visited],
            path_exists(Grid, {X + 1, Y}, End, K - 1, NewVisited) orelse
            path_exists(Grid, {X, Y + 1}, End, K - 1, NewVisited) orelse
            path_exists(Grid, {X - 1, Y}, End, K - 1, NewVisited) orelse
            path_exists(Grid, {X, Y - 1}, End, K - 1, NewVisited)
    end.