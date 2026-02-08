-module(solution).
-export([count_good_strings/3]).

count_good_strings(Low, High, Zero, One) ->
    DP = maps:new(),
    DP1 = maps:put(0, 1, DP),
    Result = helper(1, High, Zero, One, DP1, 0),
    Result.

helper(Current, High, Zero, One, DP, Sum) when Current =< High ->
    CountZero = case Current - Zero of
        N when N >= 0 -> maps:get(N, DP, 0);
        _ -> 0
    end,
    CountOne = case Current - One of
        M when M >= 0 -> maps:get(M, DP, 0);
        _ -> 0
    end,
    Total = (CountZero + CountOne) rem 1000000007,
    NewDP = maps:put(Current, Total, DP),
    NewSum = case Current >= Low of
        true -> (Sum + Total) rem 1000000007;
        false -> Sum
    end,
    helper(Current + 1, High, Zero, One, NewDP, NewSum);
helper(_, _, _, _, _, Sum) ->
    Sum.