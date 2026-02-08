-module(make_array_non_decreasing).
-export([make_array_non_decreasing/1]).

make_array_non_decreasing(Nums) ->
    make_array_non_decreasing(Nums, 0).

make_array_non_decreasing([], Res) ->
    Res;
make_array_non_decreasing([H|T], Res) ->
    make_array_non_decreasing(T, Res).