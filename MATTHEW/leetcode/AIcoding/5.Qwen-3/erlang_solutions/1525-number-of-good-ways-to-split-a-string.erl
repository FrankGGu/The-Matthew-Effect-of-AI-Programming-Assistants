-module(solution).
-export([num_good_ways/1]).

num_good_ways(S) ->
    Count = length(S),
    Left = lists:seq(0, Count - 2),
    lists:foldl(fun(I, Acc) ->
        A = string:substr(S, 1, I + 1),
        B = string:substr(S, I + 2),
        case (lists:usort(A) == lists:usort(B)) and (length(A) == length(B)) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Left).