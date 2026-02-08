-module(longest_unequal_adjacent_groups_subsequence_ii).
-export([length_of_luigs/2]).

length_of_luigs(Groups, S) ->
    N = length(Groups),
    M = length(S),
    DP = array:new(N, {default, 0}),
    Max = 0,
    lists:foreach(fun(I) -> 
        case I of
            0 -> 
                array:set(I, 1, DP);
            _ -> 
                CurrentGroup = lists:nth(I+1, Groups),
                PrevChar = lists:nth(I, S),
                array:set(I, 
                    lists:max([array:get(J, DP) + 1 || J <- lists:seq(0, I-1), 
                        lists:nth(J+1, Groups) /= CurrentGroup, 
                        lists:nth(J, S) == PrevChar]), 
                    DP)
        end
    end, lists:seq(0, N-1)),
    lists:max(array:to_list(DP)).