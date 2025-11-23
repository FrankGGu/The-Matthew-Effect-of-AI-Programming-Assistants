-module(solution).
-export([longestTrend/2]).

longestTrend(TemperatureA, TemperatureB) ->
    TrendsA = calculate_trends(TemperatureA),
    TrendsB = calculate_trends(TemperatureB),
    find_longest_match(TrendsA, TrendsB, 0, 0).

calculate_trends(Temps) ->
    calculate_trends_tr(Temps, []).

calculate_trends_tr([], Acc) -> lists:reverse(Acc);
calculate_trends_tr([_], Acc) -> lists:reverse(Acc);
calculate_trends_tr([H1, H2 | T], Acc) ->
    Trend = get_trend(H1, H2),
    calculate_trends_tr([H2 | T], [Trend | Acc]).

get_trend(T1, T2) when T2 > T1 -> 1;
get_trend(T1, T2) when T2 < T1 -> -1;
get_trend(T1, T2) when T2 == T1 -> 0.

find_longest_match([], [], MaxLen, _CurLen) -> MaxLen;
find_longest_match([HA | TA], [HB | TB], MaxLen, CurLen) ->
    if HA == HB ->
        NewCurLen = CurLen + 1,
        NewMaxLen = max(MaxLen, NewCurLen),
        find_longest_match(TA, TB, NewMaxLen, NewCurLen);
    true ->
        find_longest_match(TA, TB, MaxLen, 0)
    end;
find_longest_match(_, _, MaxLen, _CurLen) -> MaxLen.