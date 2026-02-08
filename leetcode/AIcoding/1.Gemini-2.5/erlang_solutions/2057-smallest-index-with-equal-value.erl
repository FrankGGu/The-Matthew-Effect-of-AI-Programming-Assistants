-module(solution).
-export([smallest_equal_value/1]).

smallest_equal_value(Nums) ->
    smallest_equal_value(Nums, 0).

smallest_equal_value([], _Index) ->
    -1;
smallest_equal_value([H|T], Index) ->
    if
        (Index rem 10) == H -> Index;
        true -> smallest_equal_value(T, Index + 1)
    end.