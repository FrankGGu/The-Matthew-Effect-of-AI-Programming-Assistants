-module(solution).
-export([make_equal/3]).

make_equal(S1, S2, S3) ->
    Count = lists:foldl(fun(Char, Acc) -> Acc + (Char == $a) end, 0, S1) +
            lists:foldl(fun(Char, Acc) -> Acc + (Char == $a) end, 0, S2) +
            lists:foldl(fun(Char, Acc) -> Acc + (Char == $a) end, 0, S3),
    Length = length(S1),
    Count rem Length == 0.