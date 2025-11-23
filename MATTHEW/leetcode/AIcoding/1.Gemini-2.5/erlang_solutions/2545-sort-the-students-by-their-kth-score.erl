-module(solution).
-export([sort_students/2]).

sort_students(Score, K) ->
    lists:sort(fun(Row1, Row2) -> lists:nth(K + 1, Row1) > lists:nth(K + 1, Row2) end, Score).