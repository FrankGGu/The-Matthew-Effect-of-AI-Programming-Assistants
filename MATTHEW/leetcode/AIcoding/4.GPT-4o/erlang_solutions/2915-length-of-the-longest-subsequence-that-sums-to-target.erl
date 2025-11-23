-module(solution).
-export([lengthOfLongestSubsequence/2]).

lengthOfLongestSubsequence(nums, target) ->
    Lengths = lists:duplicate(length(nums), 0),
    lists:foldl(fun(X, {Index, Acc}) ->
        NewAcc = if
            X > target -> Acc;
            true -> lists:foldl(fun(Y, Acc1) ->
                if
                    Y + X =< target -> lists:max([Acc1, Lengths[Index] + 1]);
                    true -> Acc1
                end
            end, Acc, [0..Index-1])
        end,
        {0, 0}, nums).