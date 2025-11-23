-module(solution).
-export([count_days_together/4]).

count_days_together(AliceArrive, AliceLeave, BobArrive, BobLeave) ->
    AliceStart = parse_date(AliceArrive),
    AliceEnd = parse_date(AliceLeave),
    BobStart = parse_date(BobArrive),
    BobEnd = parse_date(BobLeave),
    Start = max_date(AliceStart, BobStart),
    End = min_date(AliceEnd, BobEnd),
    case date_compare(Start, End) of
        greater -> 0;
        _ -> days_between(Start, End) + 1
    end.

parse_date(DateStr) ->
    [Month, Day] = string:tokens(DateStr, "-"),
    {list_to_integer(Month), list_to_integer(Day)}.

days_in_month(Month) ->
    case Month of
        1 -> 31;
        2 -> 28;
        3 -> 31;
        4 -> 30;
        5 -> 31;
        6 -> 30;
        7 -> 31;
        8 -> 31;
        9 -> 30;
        10 -> 31;
        11 -> 30;
        12 -> 31
    end.

days_between({M1, D1}, {M2, D2}) ->
    if
        M1 == M2 -> D2 - D1;
        true ->
            DaysInFirstMonth = days_in_month(M1) - D1,
            lists:sum([DaysInFirstMonth | [days_in_month(M) || M <- lists:seq(M1 + 1, M2 - 1)]]) + D2
    end.

max_date({M1, D1}, {M2, D2}) ->
    case M1 of
        M1 when M1 > M2 -> {M1, D1};
        M1 when M1 < M2 -> {M2, D2};
        _ ->
            case D1 of
                D1 when D1 > D2 -> {M1, D1};
                _ -> {M2, D2}
            end
    end.

min_date({M1, D1}, {M2, D2}) ->
    case M1 of
        M1 when M1 < M2 -> {M1, D1};
        M1 when M1 > M2 -> {M2, D2};
        _ ->
            case D1 of
                D1 when D1 < D2 -> {M1, D1};
                _ -> {M2, D2}
            end
    end.

date_compare({M1, D1}, {M2, D2}) ->
    if
        M1 > M2 -> greater;
        M1 < M2 -> less;
        true ->
            if
                D1 > D2 -> greater;
                D1 < D2 -> less;
                true -> equal
            end
    end.