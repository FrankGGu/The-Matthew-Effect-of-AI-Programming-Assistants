-module(solution).
-export([smoothDescentPeriods/1]).

smoothDescentPeriods([]) -> 0;
smoothDescentPeriods(Prices) ->
    count_periods(Prices, 1, 0).

count_periods([_], CurrentLength, TotalCount) ->
    TotalCount + (CurrentLength * (CurrentLength + 1) div 2);
count_periods([H1, H2 | T], CurrentLength, TotalCount) when H1 - H2 == 1 ->
    count_periods([H2 | T], CurrentLength + 1, TotalCount);
count_periods([H1, H2 | T], CurrentLength, TotalCount) ->
    NewTotalCount = TotalCount + (CurrentLength * (CurrentLength + 1) div 2),
    count_periods([H2 | T], 1, NewTotalCount).