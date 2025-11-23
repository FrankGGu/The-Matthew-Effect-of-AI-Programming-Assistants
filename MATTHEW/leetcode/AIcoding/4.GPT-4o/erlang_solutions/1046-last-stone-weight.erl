-module(solution).
-export([last_stone_weight/1]).

last_stone_weight(Stones) ->
    StonesSorted = lists:sort(fun(A, B) -> A > B end, Stones),
    last_stone_weight_helper(StonesSorted).

last_stone_weight_helper([]) -> 0;
last_stone_weight_helper([X]) -> X;
last_stone_weight_helper([X, Y | Rest]) ->
    NewStone = X - Y,
    last_stone_weight_helper([NewStone | Rest]).