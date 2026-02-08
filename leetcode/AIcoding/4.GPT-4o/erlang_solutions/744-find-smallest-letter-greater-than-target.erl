-module(solution).
-export([next_greatest_letter/2]).

next_greatest_letter(Letters, Target) ->
    Next = lists:filter(fun(X) -> X > Target end, Letters),
    case Next of
        [] -> hd(Letters);
        [H | _] -> H
    end.