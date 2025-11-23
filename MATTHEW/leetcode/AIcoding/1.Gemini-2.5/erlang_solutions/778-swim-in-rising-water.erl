-module(solution).
-export([swimInRisingWater/1]).

swimInRisingWater(Grid) ->
    N = length(Grid),

    PQ = gb_trees:empty(),
    Dist = maps:empty(),

    StartElevation = get_grid_val(0, 0, Grid),

    InitialPQ = gb_trees:insert(StartElevation, {0,0}, PQ),
    InitialDist = maps:put({0,0}, StartElevation, Dist),

    dijkstra(InitialPQ, InitialDist, N, Grid).

dijkstra(PQ, Dist, N, Grid) ->
    case gb_trees:is_empty(PQ) of
        true ->
            error(no_path);
        false ->
            {{T, {R, C}}, NewPQ} = gb_trees:take_smallest(PQ),

            case maps:get({R, C}, Dist, infinity) of
                CurrentMinMax when T > CurrentMinMax ->
                    dijkstra(NewPQ, Dist, N, Grid);
                _ ->
                    if R == N - 1 andalso C == N - 1 ->
                        T;
                    else
                        Neighbors = get_neighbors(R, C, N),
                        {UpdatedPQ, UpdatedDist} =
                            lists:foldl(
                                fun({NR, NC}, {AccPQ, AccDist}) ->
                                    NeighborElevation = get_grid_val(NR, NC, Grid),
                                    NewT = max(T, NeighborElevation),

                                    case maps:get({NR, NC}, AccDist, infinity) of
                                        OldT when NewT < OldT ->
                                            {gb_trees:insert(NewT, {NR, NC}, AccPQ), maps:put({NR, NC}, NewT, AccDist)};
                                        _ ->
                                            {AccPQ, AccDist}
                                    end
                                end,
                                {NewPQ, Dist},
                                Neighbors
                            ),
                        dijkstra(UpdatedPQ, UpdatedDist, N, Grid)
                    end
            end
    end.

get_neighbors(R, C, N) ->
    Dirs = [{0,1}, {0,-1}, {1,0}, {-1,0}],
    lists:filter(
        fun({NR, NC}) ->
            NR >= 0 andalso NR < N andalso NC >= 0 andalso NC < N
        end,
        lists:map(
            fun({DR, DC}) -> {R + DR, C + DC} end,
            Dirs
        )
    ).

get_grid_val(R, C, Grid) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).