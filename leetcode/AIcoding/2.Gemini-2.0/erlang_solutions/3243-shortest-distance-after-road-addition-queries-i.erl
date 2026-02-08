-module(shortest_distance_queries1).
-export([shortest_distance_queries/3]).

shortest_distance_queries(N, Edges, Queries) ->
    Dist = init_dist(N, Edges),
    UpdatedDist = floyd_warshall(Dist, N),

    lists:map(fun({U, V, W}) ->
        NewDist = update_dist(UpdatedDist, U, V, W, N),
        floyd_warshall(NewDist, N)
    end, Queries).

init_dist(N, Edges) ->
    Dist = array:new([N+1, N+1], {infinity, false}),

    array:set(1, array:set(1, Dist, {0, true}), {0, true}),

    lists:foldl(fun({U, V, W}, Acc) ->
        Acc1 = array:set(U+1, array:set(V+1, Acc, {W, true}), {W, true}),
        array:set(V+1, array:set(U+1, Acc1, {W, true}), {W, true})
    end, Dist, Edges).

floyd_warshall(Dist, N) ->
    lists:foldl(fun(K, Acc) ->
        lists:foldl(fun(I, Acc1) ->
            lists:foldl(fun(J, Acc2) ->
                {DistIJ, ValidIJ} = array:get(I+1, array:get(J+1, Acc2)),
                {DistIK, ValidIK} = array:get(I+1, array:get(K+1, Acc2)),
                {DistKJ, ValidKJ} = array:get(K+1, array:get(J+1, Acc2)),

                if ValidIK andalso ValidKJ ->
                    if DistIK + DistKJ < DistIJ ->
                        array:set(I+1, array:set(J+1, Acc2, {DistIK + DistKJ, true}), {DistIK + DistKJ, true})
                    else
                        Acc2
                    end
                else
                    Acc2
                end
            end, lists:seq(0, N-1), Acc1)
        end, lists:seq(0, N-1), Acc)
    end, lists:seq(0, N-1), Dist).

update_dist(Dist, U, V, W, N) ->
    NewDist = array:copy(Dist),
    NewDist1 = array:set(U+1, array:set(V+1, NewDist, {W, true}), {W, true}),
    array:set(V+1, array:set(U+1, NewDist1, {W, true}), {W, true}).