-module(houses_at_distance).
-export([count_of_pairs/3]).

count_of_pairs(N, Roads, Queries) ->
    Adj = lists:foldl(fun({U, V, W}, Acc) ->
        Acc#{U => [{V, W} | maps:get(U, Acc, [])],
              V => [{U, W} | maps:get(V, Acc, [])]}, #{}), Roads, #{}),

    Distances = calculate_distances(N, Adj),

    lists:map(fun(Query) ->
        count_distance(Distances, Query)
    end, Queries).

calculate_distances(N, Adj) ->
    lists:foldl(fun(Start, Acc) ->
        maps:put(Start, dijkstra(N, Adj, Start), Acc)
    end, #{}, lists:seq(1, N)).

dijkstra(N, Adj, Start) ->
    Dist = maps:from_list([{I, infinity} || I <- lists:seq(1, N)]),
    Dist1 = maps:put(Start, 0, Dist),

    Q = priority_queue:new(),
    Q1 = priority_queue:insert(Start, 0, Q),

    dijkstra_loop(Adj, Dist1, Q1, N).

dijkstra_loop(Adj, Dist, Q, N) ->
    case priority_queue:is_empty(Q) of
        true ->
            Dist;
        false ->
            {U, D, Q2} = priority_queue:delete_min(Q),
            Neighbors = maps:get(U, Adj, []),
            {Dist2, Q3} = lists:foldl(fun({V, W}, {AccDist, AccQ}) ->
                NewDist = maps:get(U, AccDist) + W,
                if NewDist < maps:get(V, AccDist) then
                    {maps:put(V, NewDist, AccDist), priority_queue:insert(V, NewDist, AccQ)}
                else
                    {AccDist, AccQ}
                end
            end, {Dist, Q2}, Neighbors),
            dijkstra_loop(Adj, Dist2, Q3, N)
    end.

count_distance(Distances, Query) ->
    lists:foldl(fun(Start, Acc) ->
        D = maps:get(Start, Distances),
        lists:foldl(fun({Node, Distance}, Acc2) ->
            if Node > Start andalso Distance =:= Query then
                Acc2 + 1
            else
                Acc2
            end
        end, Acc, maps:to_list(D))
    end, 0, maps:keys(Distances)).

-define(infinity, 16#7fffffff).