-module(solution).
-export([shiftingLetters/2]).

shiftingLetters(S, Shifts) ->
    N = length(S),
    Shifted = lists:foldl(fun(X, Acc) -> [((hd(Acc) + X) rem 26) + 97 | tl(Acc)] end, lists:reverse(lists:map(fun(X) -> X rem 26 end, lists:reverse(Shifts))), lists:reverse(lists:map(fun(C) -> (char_to_integer(C) - 97) rem 26 end, lists:reverse(S))),
    lists:map(fun(X) -> integer_to_char(X + 97) end, lists:reverse(Shifted)).