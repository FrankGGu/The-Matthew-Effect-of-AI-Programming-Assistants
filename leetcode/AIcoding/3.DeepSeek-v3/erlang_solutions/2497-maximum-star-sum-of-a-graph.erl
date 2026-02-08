-spec max_star_sum(Edges :: [[integer()]], K :: integer(), Values :: [integer()]) -> integer().
max_star_sum(Edges, K, Values) ->
    N = length(Values),
    Graph = lists:foldl(fun([U, V], Acc) ->
                            U1 = U + 1,
                            V1 = V + 1,
                            dict:append(U1, V1, dict:append(V1, U1, Acc))
                        end, dict:new(), Edges),
    MaxSum = lists:foldl(fun(Node, Acc) ->
                            Neighbors = case dict:find(Node, Graph) of
                                           {ok, Ns} -> Ns;
                                           error -> []
                                       end,
                            NeighborValues = lists:map(fun(Nb) -> lists:nth(Nb, Values) end, Neighbors),
                            Sorted = lists:reverse(lists:sort(NeighborValues)),
                            Selected = lists:sublist(Sorted, K),
                            Sum = lists:sum(Selected) + lists:nth(Node, Values),
                            max(Acc, Sum)
                         end, -1000000000, lists:seq(1, N)),
    MaxSum.