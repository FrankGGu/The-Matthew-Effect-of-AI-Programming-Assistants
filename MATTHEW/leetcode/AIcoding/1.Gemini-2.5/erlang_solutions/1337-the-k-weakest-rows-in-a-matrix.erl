-module(solution).
-export([k_weakest_rows/2]).

k_weakest_rows(Mat, K) ->
    IndexedRows = lists:zip(lists:seq(0, length(Mat) - 1), Mat),
    SoldierCounts = lists:map(
                      fun({Index, Row}) ->
                              Soldiers = lists:sum(Row),
                              {Soldiers, Index}
                      end,
                      IndexedRows),
    SortedRows = lists:sort(
                   fun({C1, I1}, {C2, I2}) ->
                           if
                               C1 < C2 -> true;
                               C1 > C2 -> false;
                               true -> I1 < I2
                           end
                   end,
                   SoldierCounts),
    WeakestK = lists:sublist(SortedRows, K),
    lists:map(fun({_, Index}) -> Index end, WeakestK).