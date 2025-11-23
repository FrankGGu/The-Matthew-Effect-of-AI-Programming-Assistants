-module(solution).
-export([drop_duplicate_rows/1]).

drop_duplicate_rows(Rows) ->
    gb_sets:to_list(gb_sets:from_list(Rows)).