-module(solution).
-export([cell_is_reachable/3]).

cell_is_reachable(Row, Col, Time) ->
    (Row + Col) rem 2 =:= Time rem 2 andalso Time >= abs(Row) + abs(Col).