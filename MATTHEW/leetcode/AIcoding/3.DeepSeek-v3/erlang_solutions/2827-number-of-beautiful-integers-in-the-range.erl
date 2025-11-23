-module(solution).
-export([number_of_beautiful_integers/3]).

number_of_beautiful_integers(Low, High, K) ->
    count(High, K) - count(Low - 1, K).

count(N, K) when N < 1 -> 0;
count(N, K) ->
    Digits = integer_to_list(N),
    Len = length(Digits),
    DP = init_dp(Len, K),
    {Count, _} = dfs(Digits, 0, 0, 0, 0, 1, 1, K, DP),
    Count.

init_dp(Len, K) ->
    maps:new().

dfs([], Pos, Even, Odd, Num, _, _, K, _) when Num rem K == 0, Even == Odd ->
    {1, 0};
dfs([], _, _, _, _, _, _, _, _) ->
    {0, 0};
dfs(Digits, Pos, Even, Odd, Num, Tight, LeadingZero, K, DP) ->
    Key = {Pos, Even, Odd, Num rem K, Tight, LeadingZero},
    case maps:get(Key, DP, undefined) of
        undefined ->
            MaxDigit = case Tight of 1 -> lists:nth(Pos + 1, Digits) - $0; 0 -> 9 end,
            {Total, NewDP} = lists:foldl(fun(D, {Sum, AccDP}) ->
                NewTight = case Tight of 1 -> case D == MaxDigit of true -> 1; false -> 0 end; 0 -> 0 end,
                NewLeadingZero = case LeadingZero of 1 -> case D == 0 of true -> 1; false -> 0 end; 0 -> 0 end,
                NewEven = case NewLeadingZero of 1 -> Even; 0 -> case D rem 2 == 0 of true -> Even + 1; false -> Even end end,
                NewOdd = case NewLeadingZero of 1 -> Odd; 0 -> case D rem 2 == 1 of true -> Odd + 1; false -> Odd end end,
                NewNum = (Num * 10 + D) rem K,
                {Cnt, UpdatedDP} = dfs(Digits, Pos + 1, NewEven, NewOdd, NewNum, NewTight, NewLeadingZero, K, AccDP),
                {Sum + Cnt, UpdatedDP}
            end, {0, DP}, lists:seq(0, MaxDigit)),
            {Total, maps:put(Key, Total, NewDP)};
        Cached ->
            {Cached, DP}
    end.