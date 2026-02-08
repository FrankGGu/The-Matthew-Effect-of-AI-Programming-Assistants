-module(pacific_atlantic_water_flow).
-export([pacific_atlantic/1]).

get_height(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

get_neighbors(R, C, M, N) ->
    Dirs = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],
    lists:filter(fun({NR, NC}) ->
                     NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N
                 end,
                 [{R + DR, C + DC} || {DR, DC} <- Dirs]).

bfs(Queue, Visited, Grid, M, N) ->
    case queue:out(Queue) of
        {empty, _} ->
            Visited;
        {value, {R, C}, RestQ} ->
            CurrentHeight = get_height(Grid, R, C),
            Neighbors = get_neighbors(R, C, M, N),
            {NewQ, NewV} = lists:foldl(fun({NR, NC}, {AccQ, AccV}) ->
                                           if sets:is_element({NR, NC}, AccV) ->
                                               {AccQ, AccV};
                                           else
                                               NeighborHeight = get_height(Grid, NR, NC),
                                               if NeighborHeight >= CurrentHeight ->
                                                   {queue:in({NR, NC}, AccQ), sets:add_element({NR, NC}, AccV)};
                                               else
                                                   {AccQ, AccV}
                                               end
                                           end
                                       end, {RestQ, Visited}, Neighbors),
            bfs(NewQ, NewV, Grid, M, N)
    end.

init_bfs(BorderCoords) ->
    lists:foldl(fun(Coord, {Q, V}) ->
                    {queue:in(Coord, Q), sets:add_element(Coord, V)}
                end, {queue:new(), sets:new()}, BorderCoords).

pacific_atlantic(Grid) ->
    M = length(Grid),
    case M of
        0 -> [];
        _ ->
            N = length(hd(Grid)),
            case N of
                0 -> [];
                _ ->
                    PacificBorder = [{R, 0} || R <- lists:seq(0, M-1)] ++ [{0, C} || C <- lists:seq(1, N-1)],
                    AtlanticBorder = [{R, N-1} || R <- lists:seq(0, M-1)] ++ [{M-1, C} || C <- lists:seq(0, N-2)],

                    {PacificQ, PacificV} = init_bfs(PacificBorder),
                    {AtlanticQ, AtlanticV} = init_bfs(AtlanticBorder),

                    PacificReachable = bfs(PacificQ, PacificV, Grid, M, N),
                    AtlanticReachable = bfs(AtlanticQ, AtlanticV, Grid, M, N),

                    sets:to_list(sets:intersection(PacificReachable, AtlanticReachable))
            end
    end.