-module(alternating_groups_iii).
-export([maxAlternatingGroups/1]).

maxAlternatingGroups(Nums) ->
    maxAlternatingGroups(Nums, 0, 0, 0).

maxAlternatingGroups([], _, _, Count) ->
    Count;
maxAlternatingGroups([H|T], PrevSign, PrevVal, Count) ->
    Sign = sign(H),
    case Sign of
        0 ->
            maxAlternatingGroups(T, PrevSign, PrevVal, Count);
        _ ->
            if Sign /= PrevSign orelse H =< PrevVal then
                maxAlternatingGroups(T, Sign, H, Count + 1)
            else
                maxAlternatingGroups(T, PrevSign, PrevVal, Count)
            end
    end.

sign(Num) ->
    case
        Num > 0 -> 1;
        Num < 0 -> -1;
        true -> 0
    end.