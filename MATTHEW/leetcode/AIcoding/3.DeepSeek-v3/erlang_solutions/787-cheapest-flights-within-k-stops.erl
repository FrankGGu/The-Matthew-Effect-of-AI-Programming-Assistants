-module(solution).
-export([find_cheapest_price/4]).

find_cheapest_price(N, Flights, Src, Dst) ->
    find_cheapest_price(N, Flights, Src, Dst, 0).

find_cheapest_price(N, Flights, Src, Dst, K) ->
    MaxK = K + 1,
    Dist = lists:duplicate(N, infinity),
    Dist1 = setelement(Src + 1, Dist, 0),
    Q = [{0, Src, 0}],
    bfs(Flights, Q, Dist1, Dst, MaxK).

bfs(_, [], _, _, _) -> -1;
bfs(Flights, Q, Dist, Dst, MaxK) ->
    {Cost, U, Stops} = hd(Q),
    Q1 = tl(Q),
    if
        U =:= Dst -> Cost;
        Stops =:= MaxK -> bfs(Flights, Q1, Dist, Dst, MaxK);
        true ->
            Neighbors = [ {V, W} || {F, T, W} <- Flights, F =:= U, T =:= V ],
            {NewDist, NewQ} = lists:foldl(
                fun({V, W}, {D, Queue}) ->
                    NewCost = Cost + W,
                    if
                        NewCost < element(V + 1, D) ->
                            D1 = setelement(V + 1, D, NewCost),
                            {D1, lists:umerge(Queue, [{NewCost, V, Stops + 1}])};
                        true ->
                            {D, Queue}
                    end
                end,
                {Dist, Q1},
                Neighbors
            ),
            bfs(Flights, NewQ, NewDist, Dst, MaxK)
    end.