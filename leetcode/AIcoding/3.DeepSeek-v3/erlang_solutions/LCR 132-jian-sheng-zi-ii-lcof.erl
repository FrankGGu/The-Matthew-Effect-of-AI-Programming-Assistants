-module(solution).
-export([cutting_bamboo/1]).

cutting_bamboo(N) when N =< 3 ->
    N - 1;
cutting_bamboo(N) ->
    cutting_bamboo(N, 1).

cutting_bamboo(N, Res) when N > 4 ->
    cutting_bamboo(N - 3, (Res * 3) rem 1000000007);
cutting_bamboo(N, Res) ->
    (Res * N) rem 1000000007.