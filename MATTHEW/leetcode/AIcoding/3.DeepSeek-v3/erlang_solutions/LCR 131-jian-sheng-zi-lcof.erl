-module(solution).
-export([cutting_bamboo/1]).

cutting_bamboo(N) when N =< 3 ->
    N - 1;
cutting_bamboo(N) ->
    cutting_bamboo(N, 1).

cutting_bamboo(N, Product) when N =< 4 ->
    Product * N;
cutting_bamboo(N, Product) ->
    cutting_bamboo(N - 3, Product * 3).