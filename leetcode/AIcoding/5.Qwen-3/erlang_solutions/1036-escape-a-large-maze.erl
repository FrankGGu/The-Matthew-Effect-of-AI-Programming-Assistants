-module(escape_a_large_maze).
-export([is_escape_possible/2]).

is_escape_possible(Obstacles, Target) ->
    IsVisited = maps:new(),
    {X, Y} = Target,
    MaxX = 10^6,
    MaxY = 10^6,
    is_escape_possible(Obstacles, Target, {0, 0}, IsVisited, MaxX, MaxY).

is_escape_possible(_Obstacles, _Target, {X, Y}, _IsVisited, MaxX, MaxY) when X < 0 orelse Y < 0 orelse X > MaxX orelse Y > MaxY ->
    false;
is_escape_possible(Obstacles, Target, {X, Y}, IsVisited, _MaxX, _MaxY) when X == element(1, Target), Y == element(2, Target) ->
    true;
is_escape_possible(Obstacles, Target, {X, Y}, IsVisited, MaxX, MaxY) ->
    case maps:get({X, Y}, IsVisited, false) of
        true -> false;
        false ->
            NewIsVisited = maps:put({X, Y}, true, IsVisited),
            ObstacleSet = sets:from_list(Obstacles),
            if
                sets:is_element({X, Y}, ObstacleSet) -> false;
                true ->
                    Directions = [{0,1},{1,0},{0,-1},{-1,0}],
                    lists:any(fun({DX, DY}) ->
                                      is_escape_possible(Obstacles, Target, {X+DX, Y+DY}, NewIsVisited, MaxX, MaxY)
                              end, Directions)
            end
    end.