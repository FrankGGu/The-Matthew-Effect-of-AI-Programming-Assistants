-module(solution).
-export([people_aware_of_secret/3]).

people_aware_of_secret(N, Delay, Forget) ->
    DP = lists:duplicate(N + 1, 0),
    DP1 = lists:sublist(DP, 1, 1) ++ [1] ++ lists:sublist(DP, 3, length(DP) - 2),
    people_aware_of_secret(N, Delay, Forget, 2, DP1).

people_aware_of_secret(N, _Delay, _Forget, Day, DP) when Day > N ->
    lists:sum(lists:sublist(DP, N - lists:min(Forget, N) + 1, lists:min(Forget, N))) rem 1000000007;
people_aware_of_secret(N, Delay, Forget, Day, DP) ->
    NewShare = if
        Day - Delay >= 1 -> lists:nth(Day - Delay, DP);
        true -> 0
    end,
    NewForget = if
        Day - Forget >= 1 -> lists:nth(Day - Forget, DP);
        true -> 0
    end,
    Current = (lists:nth(Day - 1, DP) + NewShare - NewForget) rem 1000000007,
    CurrentPos = if Current < 0 -> Current + 1000000007; true -> Current end,
    NewDP = lists:sublist(DP, 1, Day) ++ [CurrentPos] ++ lists:sublist(DP, Day + 2, length(DP) - Day - 1),
    people_aware_of_secret(N, Delay, Forget, Day + 1, NewDP).