-module(solution).
-export([check_record/1]).

check_record(N) ->
    Mod = 1000000007,
    DP = lists:duplicate(6, 0),
    DP1 = setelement(1, DP, 1),
    DP2 = setelement(2, DP1, 1),
    DP3 = setelement(4, DP2, 1),
    Ans = helper(N, Mod, DP3),
    Ans.

helper(0, _, DP) ->
    (element(1, DP) + element(2, DP) + element(3, DP) + element(4, DP) + element(5, DP) + element(6, DP)) rem 1000000007;
helper(N, Mod, DP) ->
    NewDP1 = (element(1, DP) + element(2, DP) + element(3, DP)) rem Mod,
    NewDP2 = element(1, DP),
    NewDP3 = element(2, DP),
    NewDP4 = (element(4, DP) + element(5, DP) + element(6, DP)) rem Mod,
    NewDP5 = element(4, DP),
    NewDP6 = element(5, DP),
    NewDP = {NewDP1, NewDP2, NewDP3, NewDP4, NewDP5, NewDP6},
    helper(N - 1, Mod, NewDP).