-module(solution).
-export([maxScore/2]).

maxScore(Grid, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxScores = lists:map(fun(Row) -> lists:map(fun(Cell) -> Cell end, Row) end, Grid),
    lists:max(lists:map(fun(X) -> lists:sum(lists:sublist(X, K)) end, lists:transpose(MaxScores))).