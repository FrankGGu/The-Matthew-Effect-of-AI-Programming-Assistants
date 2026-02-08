-module(solution).
-export([latest_day_to_cross/3]).

latest_day_to_cross(N, S, A) ->
    binary_search(N, S, A, 1, N).

binary_search(N, S, A, Low, High) ->
    case Low =< High of
        true ->
            Mid = (Low + High) div 2,
            if 
                can_cross(N, S, A, Mid) ->
                    binary_search(N, S, A, Mid + 1, High);
                true ->
                    binary_search(N, S, A, Low, Mid - 1)
            end;
        false ->
            High
    end.

can_cross(N, S, A, day) ->
    Grid = lists:duplicate(N, lists:duplicate(N, 1)),
    lists:foreach(fun({X, Y}) -> Grid = lists:replace_element(X + 1, lists:replace_element(Y + 1, 0, lists:nth(X + 1, Grid)), Grid) end, A),
    is_crossable(Grid, N, S, day).

is_crossable(Grid, N, S, day) ->
    lists:foldl(fun(X, Acc) -> Acc orelse can_reach_end(Grid, N, X, day) end, false, lists:seq(1, N)).

can_reach_end(Grid, N, X, day) ->
    case Grid of
        [] -> false;
        _  -> lists:member(X, lists:map(fun(Y) -> is_valid_move(Grid, N, X, Y, day, lists:duplicate(N, false)) end, lists:seq(1, N))) 
    end.

is_valid_move(Grid, N, X, Y, day, Visited) ->
    if 
        X < 1 orelse X > N orelse Y < 1 orelse Y > N orelse lists:nth(X, lists:nth(Y, Grid)) =:= 0 orelse lists:nth(X, Visited) =:= true ->
            false;
        Y =:= N -> 
            true;
        true -> 
            Visited1 = lists:replace_element(X, true, Visited),
            lists:foldl(fun(DX, Acc) -> Acc orelse is_valid_move(Grid, N, X + DX, Y + 1, day, Visited1) end, false, [-1, 0, 1])
    end.