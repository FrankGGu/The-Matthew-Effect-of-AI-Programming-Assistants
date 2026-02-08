-spec find_min_height_trees(N :: integer(), Edges :: [[integer()]]) -> [integer()].
find_min_height_trees(N, Edges) when N =:= 1 -> [0];
find_min_height_trees(N, Edges) ->
    Adj = lists:foldl(fun([U, V], Acc) ->
                          maps:update_with(U, fun(L) -> [V | L] end, [V], Acc)
                      end, #{}, Edges),
    Adj1 = lists:foldl(fun([U, V], Acc) ->
                          maps:update_with(V, fun(L) -> [U | L] end, [U], Acc)
                       end, Adj, Edges),
    Leaves = maps:fold(fun(K, V, Acc) when length(V) =:= 1 -> [K | Acc];
                          (_, _, Acc) -> Acc
                       end, [], Adj1),
    find_mht(N, Adj1, Leaves).

find_mht(N, Adj, Leaves) when N =< 2 -> Leaves;
find_mht(N, Adj, Leaves) ->
    NewLeaves = lists:foldl(fun(Leaf, Acc) ->
                               [Neighbor | _] = maps:get(Leaf, Adj),
                               Adj1 = maps:update_with(Neighbor, fun(L) -> lists:delete(Leaf, L) end, Adj),
                               case length(maps:get(Neighbor, Adj1)) of
                                   1 -> [Neighbor | Acc];
                                   _ -> Acc
                               end
                            end, [], Leaves),
    find_mht(N - length(Leaves), Adj1, NewLeaves).