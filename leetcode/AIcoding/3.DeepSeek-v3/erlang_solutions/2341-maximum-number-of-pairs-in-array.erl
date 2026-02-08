-spec number_of_pairs(:: [integer()]) -> [integer()].
number_of_pairs(Nums) ->
    Counts = lists:foldl(fun(N, Acc) -> 
                            maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) 
                         end, #{}, Nums),
    {Pairs, Left} = maps:fold(fun(_, V, {P, L}) -> 
                                {P + V div 2, L + V rem 2} 
                              end, {0, 0}, Counts),
    [Pairs, Left].