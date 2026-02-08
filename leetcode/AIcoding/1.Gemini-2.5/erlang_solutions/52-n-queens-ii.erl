-module(solution).
-export([totalNQueens/1]).

totalNQueens(N) ->
    backtrack(0, N, sets:new(), sets:new(), sets:new()).

backtrack(Row, N, ColsSet, Diag1Set, Diag2Set) when Row == N ->
    1;
backtrack(Row, N, ColsSet, Diag1Set, Diag2Set) when Row < N ->
    lists:sum([
        backtrack(Row + 1, N, sets:add_element(Col, ColsSet), sets:add_element(Row - Col, Diag1Set), sets:add_element(Row + Col, Diag2Set))
        || Col <- lists:seq(0, N - 1),
           not sets:is_element(Col, ColsSet),
           not sets:is_element(Row - Col, Diag1Set),
           not sets:is_element(Row + Col, Diag2Set)
    ]).