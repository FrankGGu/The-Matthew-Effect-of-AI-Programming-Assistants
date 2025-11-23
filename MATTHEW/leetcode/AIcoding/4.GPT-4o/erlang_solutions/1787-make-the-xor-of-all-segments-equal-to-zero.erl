-module(solution).
-export([make_xor_zero/1]).

make_xor_zero(X) ->
    lists:sum(X) rem 2 =:= 0.