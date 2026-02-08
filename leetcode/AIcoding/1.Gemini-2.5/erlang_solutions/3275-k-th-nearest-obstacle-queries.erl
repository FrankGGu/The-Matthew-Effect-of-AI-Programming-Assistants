-module(solution).
-export([k_th_nearest_obstacle_queries/2]).

k_th_nearest_obstacle_queries(Obstacles, Queries) ->
    lists:map(fun(Query) -> handle_query(Obstacles, Query) end, Queries).

handle_query(Obstacles, [QX, QY, K]) ->
    Distances = lists:map(fun([OX, OY]) ->
                                  DX = OX - QX,
                                  DY = OY - QY,
                                  DX*DX + DY*DY
                          end, Obstacles),
    SortedDistances = lists:sort(Distances),
    case K > 0 andalso K =< length(SortedDistances) of
        true -> lists:nth(K, SortedDistances);
        false -> -1
    end.