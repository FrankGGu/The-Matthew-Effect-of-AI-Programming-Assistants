-module(minimum_cost_to_move_chips).
-export([min_cost_to_move_chips/1]).

min_cost_to_move_chips(Chips) ->
    Even = lists:foldl(fun(X, Acc) -> if X rem 2 == 0 -> Acc + 1; true -> Acc end end, 0, Chips),
    lists:min([Even, length(Chips) - Even]).