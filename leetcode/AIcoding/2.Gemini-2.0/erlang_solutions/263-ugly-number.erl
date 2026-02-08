-module(ugly_number).
-export([is_ugly/1]).

is_ugly(N) when N =< 0 ->
    false;
is_ugly(1) ->
    true;
is_ugly(N) ->
    U = divide_by_factor(N, 2),
    V = divide_by_factor(U, 3),
    W = divide_by_factor(V, 5),
    W == 1.

divide_by_factor(N, Factor) when N rem Factor == 0 ->
    divide_by_factor(N div Factor, Factor);
divide_by_factor(N, _Factor) ->
    N.