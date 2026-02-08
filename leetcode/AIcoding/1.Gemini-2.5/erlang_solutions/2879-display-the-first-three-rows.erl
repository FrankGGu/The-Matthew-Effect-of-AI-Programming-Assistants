-module(solution).
-export([display_first_three_rows/1]).

display_first_three_rows(Rows) ->
    lists:sublist(Rows, 3).