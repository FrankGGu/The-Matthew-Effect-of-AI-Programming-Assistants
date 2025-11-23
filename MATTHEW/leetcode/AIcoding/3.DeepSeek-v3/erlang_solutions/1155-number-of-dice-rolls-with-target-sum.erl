-module(solution).
-export([num_rolls_to_target/3]).

num_rolls_to_target(D, F, Target) ->
    DP = maps:new(),
    DP1 = maps:put({0, 0}, 1, DP),
    Ans = helper(D, F, Target, DP1),
    Ans.

helper(D, F, Target, DP) ->
    case maps:get({D, Target}, DP, -1) of
        -1 ->
            if
                D =:= 0 -> 0;
                true ->
                    Sum = lists:sum(
                            [helper(D - 1, F, Target - K, DP) 
                             || K <- lists:seq(1, F), 
                                Target - K >= 0]),
                    DP1 = maps:put({D, Target}, Sum rem 1000000007, DP),
                    helper(D, F, Target, DP1)
            end;
        Val -> Val
    end.