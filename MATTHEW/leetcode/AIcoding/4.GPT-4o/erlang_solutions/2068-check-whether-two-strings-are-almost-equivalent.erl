-module(solution).
-export([check_almost_equivalent/2]).

check_almost_equivalent(Str1, Str2) ->
    Count1 = lists:foldl(fun(Char, Acc) -> Acc + (if Char =:= $a -> 1; Char =:= $b -> -1; true -> 0 end) end, 0, Str1),
    Count2 = lists:foldl(fun(Char, Acc) -> Acc + (if Char =:= $a -> 1; Char =:= $b -> -1; true -> 0 end) end, 0, Str2),
    (Count1 =:= Count2 orelse Count1 + 1 =:= Count2 orelse Count1 - 1 =:= Count2).