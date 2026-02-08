-module(solution).
-export([count_total_colored_cells/1]).

count_total_colored_cells(N) ->
    count_total_colored_cells(N, 1, 0).

count_total_colored_cells(0, _, Acc) ->
    Acc;
count_total_colored_cells(N, K, Acc) ->
    count_total_colored_cells(N - 1, K + 2, Acc + K).