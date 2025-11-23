-module(solution).
-export([count_pairs/1]).

count_pairs(Days) ->
    lists:foldl(fun(X, Acc) -> Acc + count_day_pairs(X) end, 0, Days).

count_day_pairs(Day) ->
    case Day of
        {M, D} when M > 0, M < 13, D > 0, D =< days_in_month(M) -> 1;
        _ -> 0
    end.

days_in_month(M) ->
    case M of
        1 -> 31;
        2 -> 28; % Not considering leap years
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