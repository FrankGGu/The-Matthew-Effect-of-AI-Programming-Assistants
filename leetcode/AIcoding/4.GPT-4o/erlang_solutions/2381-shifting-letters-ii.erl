-module(solution).
-export([shifting_letters/3]).

shifting_letters(S, Shifts) ->
    N = length(S),
    Shifted = lists:foldl(fun({C, Shift}, Acc) ->
        NewShift = (hd(Acc) + Shift) rem 26,
        [((C - $a + NewShift) rem 26) + $a | tl(Acc)]
    end, [0 | lists:reverse(Shifts)], lists:zip(lists:map(fun($A) -> $A end, string:to_list(S)), [0 | lists:reverse(Shifts)])),
    string:from_list(lists:reverse(Shifted)).