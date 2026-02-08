-module(max_alternating_subsequence_sum).
-export([max_alt_sum/1]).

max_alt_sum(Numbers) ->
    max_alt_sum(Numbers, 0, 0, 0).

max_alt_sum([], Pos, Neg, _) -> 
    max(Pos, Neg);
max_alt_sum([H | T], Pos, Neg, Sign) ->
    case Sign of
        0 ->
            NewPos = max(Pos + H, Neg + H),
            max_alt_sum(T, NewPos, Neg, 1);
        1 ->
            NewNeg = max(Neg + H, Pos + H),
            max_alt_sum(T, Pos, NewNeg, 0)
    end.