-module(solution).
-export([generateTheString/1]).

generateTheString(N) when N rem 2 =:= 1 ->
    lists:duplicate(N, $a);
generateTheString(N) when N rem 2 =:= 0 ->
    lists:duplicate(N - 1, $a) ++ [$b].