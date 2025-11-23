-module(solution).
-export([min_moves_to_make_palindrome/1]).

min_moves_to_make_palindrome(Str) ->
    CharCounts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, map:new(), Str),
    OddCount = maps:fold(fun(_, V, Acc) -> if V rem 2 =:= 1 -> Acc + 1; true -> Acc end end, 0, CharCounts),
    Length = length(Str),
    (Length - OddCount) div 2.