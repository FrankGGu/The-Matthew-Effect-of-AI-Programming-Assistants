-module(solution).
-export([can_form_palindrome/2]).

can_form_palindrome(S, Queries) ->
    CharCounts = lists:foldl(fun (C, Acc) -> 
        case maps:find(C, Acc) of
            {ok, Count} -> maps:update(C, Count + 1, Acc);
            error -> maps:put(C, 1, Acc)
        end
    end, #{}, string:to_list(S)),
    OddCount = maps:fold(fun(_, Count, Acc) -> if Count rem 2 =:= 1 -> Acc + 1; true -> Acc end end, 0, CharCounts),
    lists:map(fun {L, R} -> OddCount =< (R - L + 1) div 2 end, Queries).