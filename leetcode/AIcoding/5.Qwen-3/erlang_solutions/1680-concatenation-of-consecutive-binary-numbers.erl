-module(solution).
-export([concatenation/1]).

concatenation(N) ->
    Concat = fun(Num, Acc) -> Acc bsl (integer_to_binary(Num) length()) + Num end,
    lists:foldl(Concat, 0, lists:seq(1, N)).