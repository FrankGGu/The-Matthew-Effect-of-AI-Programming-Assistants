-module(min_cost_to_change_final_value_of_expression).
-export([minCost/1]).

minCost(Expression) ->
    {Expr, _} = parse(Expression, 0),
    Cost = calculate_cost(Expr),
    Cost.

parse([], _) -> {0, 0};
parse([C | Rest], Pos) when C == $+; C == $* ->
    Op = case C of
             $+ -> '+';
             $* -> '*'
         end,
    {Left, NewPos} = parse(Rest, Pos + 1),
    {Right, _} = parse(Rest, NewPos),
    {{Op, Left, Right}, NewPos};
parse([C | Rest], Pos) when C >= $0, C =< $9 ->
    Num = list_to_integer([C | get_digits(Rest, 0)]),
    {Num, Pos + length(integer_to_list(Num))}.

get_digits([], Acc) -> [];
get_digits([C | Rest], Acc) when C >= $0, C =< $9 ->
    [C | get_digits(Rest, Acc + 1)];
get_digits(_, _) -> [].

calculate_cost({Num}) -> 0;
calculate_cost({'+', Left, Right}) ->
    LCost = calculate_cost(Left),
    RCost = calculate_cost(Right),
    min(LCost + RCost, 1 + LCost + RCost, 1 + LCost + RCost);
calculate_cost({'*', Left, Right}) ->
    LCost = calculate_cost(Left),
    RCost = calculate_cost(Right),
    min(LCost + RCost, 1 + LCost + RCost, 1 + LCost + RCost).