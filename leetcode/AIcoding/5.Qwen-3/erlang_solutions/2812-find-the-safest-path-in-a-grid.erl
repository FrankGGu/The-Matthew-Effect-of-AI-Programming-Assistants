-module(safe_path).
-export([safe_path/1]).

safe_path(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Distances = compute_distances(Grid, Rows, Cols),
    {Min, Max} = lists:foldl(fun({X,Y}, {MinAcc, MaxAcc}) -> 
        if Grid#{{X,Y}} == 0 -> {MinAcc, max(MaxAcc, Distances#{{X,Y}})}; true -> {min(MinAcc, Distances#{{X,Y}}), MaxAcc} end
    end, {infinity, 0}, lists:seq(1, Rows) ++ lists:seq(1, Cols)), % Find min and max distances
    find_safest_path(Distances, Rows, Cols, Min, Max).

compute_distances(Grid, Rows, Cols) ->
    Distances = maps:new(),
    Q = queue:new(),
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            if Grid#{{I,J}} == 0 -> 
                Distances1 = maps:put({I,J}, 0, Distances),
                Q1 = queue:in({I,J}, Q),
                {Distances1, Q1};
            true -> {Distances, Q}
            end
        end, lists:seq(1, Cols))
    end, lists:seq(1, Rows)),
    bfs(Distances, Q, Rows, Cols).

bfs(Distances, Q, Rows, Cols) ->
    case queue:out(Q) of
        {empty, _} -> Distances;
        {{value, {X, Y}}, Q1} ->
            Neighbors = [{X+1,Y}, {X-1,Y}, {X,Y+1}, {X,Y-1}],
            lists:foreach(fun({NX, NY}) ->
                if NX >= 1, NX =< Rows, NY >= 1, NY =< Cols, not maps:is_key({NX, NY}, Distances) -> 
                    Dist = maps:get({X, Y}, Distances) + 1,
                    Distances1 = maps:put({NX, NY}, Dist, Distances),
                    Q2 = queue:in({NX, NY}, Q1),
                    bfs(Distances1, Q2, Rows, Cols);
                true -> ok
                end
            end, Neighbors),
            bfs(Distances, Q1, Rows, Cols)
    end.

find_safest_path(Distances, Rows, Cols, Min, Max) ->
    find_safest_path(Distances, Rows, Cols, Min, Max, 1, 1, []).

find_safest_path(Distances, Rows, Cols, Min, Max, X, Y, Path) ->
    if X > Rows orelse Y > Cols -> 
        case Path of [] -> -1; _ -> lists:last(Path) end;
    true ->
        Current = maps:get({X, Y}, Distances),
        if Current < Min -> find_safest_path(Distances, Rows, Cols, Min, Max, X+1, Y, Path);
        true ->
            NewPath = [Current | Path],
            Down = find_safest_path(Distances, Rows, Cols, Min, Max, X+1, Y, NewPath),
            Right = find_safest_path(Distances, Rows, Cols, Min, Max, X, Y+1, NewPath),
            case {Down, Right} of
                {_, -1} -> Down;
                {-1, _} -> Right;
                {D, R} -> min(D, R)
            end
        end
    end.