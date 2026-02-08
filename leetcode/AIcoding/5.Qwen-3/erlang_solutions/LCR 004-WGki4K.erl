-module(solution).
-export([single_number/1]).

single_number(Nums) ->
    single_number(Nums, 0, 0).

single_number([], A, _) ->
    A;
single_number([H | T], A, B) ->
    NewA = (A band (H bnot)) bor (B band H),
    NewB = (B band (H bnot)) bor (A band H),
    single_number(T, NewA, NewB).