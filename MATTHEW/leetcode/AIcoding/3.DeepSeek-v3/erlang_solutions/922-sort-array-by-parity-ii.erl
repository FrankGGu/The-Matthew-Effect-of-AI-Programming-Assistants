-spec sort_array_by_parity_ii(Nums :: [integer()]) -> [integer()].
sort_array_by_parity_ii(Nums) ->
    {Evens, Odds} = lists:partition(fun(X) -> X rem 2 == 0 end, Nums),
    interleave(Evens, Odds, []).

interleave([], [], Acc) -> lists:reverse(Acc);
interleave([E|Es], [O|Os], Acc) -> interleave(Es, Os, [O, E|Acc]).