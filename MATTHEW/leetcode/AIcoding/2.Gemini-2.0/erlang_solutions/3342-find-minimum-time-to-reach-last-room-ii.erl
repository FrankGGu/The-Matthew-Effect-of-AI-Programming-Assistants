-module(find_minimum_time_to_reach_last_room_ii).
-export([minimum_time/3]).

minimum_time(corridors, strength, k) ->
    N = length(corridors),
    Adj = lists:foldl(fun([U, V, W], Acc) ->
                           Acc#{U => lists:append(maps:get(U, Acc, []), [{V, W}]),
                               V => lists:append(maps:get(V, Acc, []), [{U, W}])
                           }
                       end, #{}, corridors),
    dijkstra(Adj, strength, 1, N, k).

dijkstra(Adj, Strength, Start, Target, K) ->
    N = maps:size(Adj) + 1,
    Dist = lists:foldl(fun(I, Acc) -> Acc#{I => infinity} end, #{}, lists:seq(1, N)),
    Dist1 = Dist#{Start => 0},
    Q = gb_sets:from_list([{0, Start}]),
    dijkstra_helper(Adj, Strength, Target, K, Dist1, Q).

dijkstra_helper(Adj, Strength, Target, K, Dist, Q) ->
    case gb_sets:is_empty(Q) of
        true -> maps:get(Target, Dist, infinity);
        false ->
            {_, {D, U}} = gb_sets:take_smallest(Q),
            Q1 = gb_sets:delete(D, U, Q),
            case maps:get(U, Dist) < D of
                true -> dijkstra_helper(Adj, Strength, Target, K, Dist, Q1);
                false ->
                    Neighbors = maps:get(U, Adj, []),
                    {NewDist, NewQ} = lists:foldl(fun({V, W}, {AccDist, AccQ}) ->
                                                     Wait = max(0, maps:get(U, AccDist) - Strength),
                                                     NewCost = maps:get(U, AccDist) + W + Wait * K,
                                                     case maps:get(V, AccDist, infinity) > NewCost of
                                                         true ->
                                                             NewDist1 = AccDist#{V => NewCost},
                                                             NewQ1 = gb_sets:add({NewCost, V}, AccQ);
                                                         false ->
                                                             NewDist1 = AccDist,
                                                             NewQ1 = AccQ
                                                     end,
                                                     {NewDist1, NewQ1}
                                                 end, {Dist, Q1}, Neighbors),
                    dijkstra_helper(Adj, Strength, Target, K, NewDist, NewQ)
            end
    end.