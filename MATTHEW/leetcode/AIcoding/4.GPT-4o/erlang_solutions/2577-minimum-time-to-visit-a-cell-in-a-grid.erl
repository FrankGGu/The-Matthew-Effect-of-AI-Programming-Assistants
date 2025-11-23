-module(solution).
-export([minimum_time/2]).

minimum_time(Grid, Start) ->
    StartX = element(1, Start),
    StartY = element(2, Start),
    MinTime = minimum_time_helper(Grid, StartX, StartY, 0, []),
    MinTime.

minimum_time_helper(_, X, Y, Time, Visited) when X < 1; Y < 1; X > length(Grid); Y > length(element(X, Grid)) -> 
    infinity;
minimum_time_helper(Grid, X, Y, Time, Visited) ->
    if
        lists:member({X, Y}, Visited) -> 
            infinity;
        true -> 
            NewVisited = [{X, Y} | Visited],
            CurrentTime = element(Y, element(X, Grid)),
            TimeSpent = Time + CurrentTime,
            Right = minimum_time_helper(Grid, X + 1, Y, TimeSpent, NewVisited),
            Down = minimum_time_helper(Grid, X, Y + 1, TimeSpent, NewVisited),
            Up = minimum_time_helper(Grid, X - 1, Y, TimeSpent, NewVisited),
            Left = minimum_time_helper(Grid, X, Y - 1, TimeSpent, NewVisited),
            lists:min([TimeSpent, Right, Down, Up, Left])
    end.