-module(paint_house_iv).
-export([min_cost/1]).

min_cost(Houses) ->
    min_cost(Houses, 0, 0, 0, 0).

min_cost([], Cost1, Cost2, Cost3, _Acc) ->
    min(Cost1, Cost2, Cost3);
min_cost([H | T], Cost1, Cost2, Cost3, Acc) ->
    NewCost1 = H + min(Cost2, Cost3),
    NewCost2 = H + min(Cost1, Cost3),
    NewCost3 = H + min(Cost1, Cost2),
    min_cost(T, NewCost1, NewCost2, NewCost3, Acc + 1).

min(A, B, C) when A < B, A < C -> A;
min(A, B, C) when B < A, B < C -> B;
min(_, _, C) -> C.