-module(solution).
-export([are_occurrences_equal/1]).

are_occurrences_equal(S) ->
    lists:all(fun(C) -> C == $a orelse C == $b end, S),
    A = lists:foldl(fun($a, Acc) -> Acc + 1; (_, Acc) -> Acc end, 0, S),
    B = lists:foldl(fun($b, Acc) -> Acc + 1; (_, Acc) -> Acc end, 0, S),
    A >= B.