-module(alternating_groups_ii).
-export([numberOfAlternatingGroups/1]).

numberOfAlternatingGroups(S) ->
    N = length(S),
    Count = 0,
    lists:foldl(fun(I, Acc) -> 
        case I + 2 =< N of
            true ->
                A = lists:nth(I, S),
                B = lists:nth(I+1, S),
                C = lists:nth(I+2, S),
                if (A /= B andalso B /= C) -> Acc + 1;
                   true -> Acc
                end;
            false -> Acc
        end
    end, Count, lists:seq(1, N-2)).