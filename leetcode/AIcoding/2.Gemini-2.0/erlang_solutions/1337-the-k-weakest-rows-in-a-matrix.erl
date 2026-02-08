-module(weakest_rows).
-export([k_weakest_rows/2]).

k_weakest_rows(Mat, K) ->
    Rows = lists:seq(0, length(Mat) - 1),
    Strengths = lists:map(fun(Row) -> 
                                 Strength = lists:sum(lists:nth(Row + 1, Mat)),
                                 {Strength, Row}
                             end, Rows),
    SortedStrengths = lists:keysort(1, Strengths),
    WeakestRows = lists:map(fun({_, Row}) -> Row end, lists:sublist(SortedStrengths, 1, K)),
    WeakestRows.