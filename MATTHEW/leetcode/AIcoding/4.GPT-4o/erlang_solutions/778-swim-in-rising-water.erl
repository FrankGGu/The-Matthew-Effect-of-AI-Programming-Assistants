-module(solution).
-export([swim_in_water/1]).

swim_in_water(heights) ->
    N = length(heights),
    Grid = lists:map(fun(Row) -> lists:map(fun(X) -> {X} end, Row) end, heights),
    swim_in_water_helper(Grid, N).

swim_in_water_helper(Grid, N) ->
    {Min, Max} = lists:foldl(fun({Row, R}, {MinAcc, MaxAcc}) -> 
                                    lists:foldl(fun(X, {MinAcc2, MaxAcc2}) -> 
                                        {min(MinAcc2, X), max(MaxAcc2, X)} 
                                    end, {MinAcc, MaxAcc}, Row)
                                end, {infinity, -infinity}, lists:zip(Grid, lists:seq(1, N))),
    bfs(Grid, N, Min, Max).

bfs(Grid, N, Min, Max) ->
    L = lists:seq(Min, Max),
    lists:foldl(fun(WaterLevel, Acc) ->
        case bfs_helper(Grid, N, WaterLevel) of
            {ok, Path} -> lists:append(Acc, [{WaterLevel, Path}]);
            _ -> Acc
        end
    end, [], L).

bfs_helper(Grid, N, WaterLevel) ->
    case bfs_search(Grid, N, WaterLevel, [{0, 0}], #{}) of
        true -> {ok, WaterLevel};
        false -> {error, not_found}
    end.

bfs_search(_, N, WaterLevel, [], _) -> false;
bfs_search(Grid, N, WaterLevel, [{X, Y} | Rest], Visited) ->
    if 
        X < 0 orelse Y < 0 orelse X >= N orelse Y >= N -> bfs_search(Grid, N, WaterLevel, Rest, Visited);
        maps:is_key({X, Y}, Visited) -> bfs_search(Grid, N, WaterLevel, Rest, Visited);
        lists:nth(Y + 1, lists:nth(X + 1, Grid)) =< WaterLevel -> 
            if 
                X == N - 1, Y == N - 1 -> true;
                true -> 
                    NewVisited = maps:put({X, Y}, true, Visited),
                    bfs_search(Grid, N, WaterLevel, [{X + 1, Y}, {X, Y + 1}, {X - 1, Y}, {X, Y - 1} | Rest], NewVisited)
            end;
        true -> bfs_search(Grid, N, WaterLevel, Rest, Visited)
    end.