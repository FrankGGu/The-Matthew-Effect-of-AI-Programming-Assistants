-module(solution).
-export([is_ugly/1]).

-spec is_ugly(N :: integer()) -> boolean().
is_ugly(N) when N =< 0 ->
    false;
is_ugly(1) ->
    true;
is_ugly(N) ->
    N2 = divide_factor(N, 2),
    N3 = divide_factor(N2, 3),
    N5 = divide_factor(N3, 5),
    N5 == 1.

divide_factor(Num, Factor) when Num rem Factor == 0 ->
    divide_factor(Num div Factor, Factor);
divide_factor(Num, _Factor) ->
    Num.