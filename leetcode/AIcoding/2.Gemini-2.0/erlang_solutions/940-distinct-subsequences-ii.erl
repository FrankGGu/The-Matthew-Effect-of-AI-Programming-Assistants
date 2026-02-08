-module(distinct_subsequences_ii).
-export([num_distinct/1]).

num_distinct(S) ->
    num_distinct(S, 0, [], 1000000007).

num_distinct([], _, _, _) ->
    0;
num_distinct(S, Start, Last, Mod) ->
    Len = length(S),
    dp(S, Len, Last, Mod).

dp(S, Len, Last, Mod) ->
    dp(S, Len, 0, Last, Mod, [1 | lists:seq(1, Len)]).

dp(_, 0, _, _, _, DP) ->
    (lists:last(DP) - 1 + Mod) rem Mod;
dp(S, I, LastIndex, Last, Mod, DP) ->
    CharCode = element(1, string:to_integer(string:substr(S, I, 1))),
    NewDP = case lists:keyfind(CharCode, 1, Last) of
        false ->
            NewVal = (lists:nth(I, DP) * 2) rem Mod,
            NewDPList = lists:nthtail(1, DP) ++ [NewVal],
            dp(S, I - 1, CharCode, [{CharCode, I} | Last], Mod, NewDPList);
        {_, LastPos} ->
            NewVal = ((lists:nth(I, DP) * 2) - lists:nth(LastPos, DP) + Mod) rem Mod,
            NewDPList = lists:nthtail(1, DP) ++ [NewVal],
            dp(S, I - 1, CharCode, lists:keyreplace(CharCode, 1, Last, {CharCode, I}), Mod, NewDPList)
    end.