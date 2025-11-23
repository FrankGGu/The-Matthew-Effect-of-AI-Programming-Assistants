-module(solution).
-export([next_greatest_letter/2]).

next_greatest_letter(Letters, Target) ->
    next_greatest_letter(Letters, Target, hd(Letters)).

next_greatest_letter([], _Target, Result) ->
    Result;
next_greatest_letter([H | T], Target, Result) ->
    if
        H > Target ->
            case H < Result of
                true -> next_greatest_letter(T, Target, H);
                false -> next_greatest_letter(T, Target, Result)
            end;
        true ->
            next_greatest_letter(T, Target, Result)
    end.