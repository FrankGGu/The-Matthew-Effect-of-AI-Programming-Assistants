-module(maximum_count).
-export([maximum_count/1]).

maximum_count(Nums) ->
    {Pos, Neg} = lists:foldl(fun
        (X, {P, N}) when X > 0 -> {P + 1, N};
        (X, {P, N}) when X < 0 -> {P, N + 1};
        (_, Acc) -> Acc
    end, {0, 0}, Nums),
    max(Pos, Neg).