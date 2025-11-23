-module(solution).
-export([sorted_squares/1]).

sorted_squares(Input) ->
    SortedSquares = lists:map(fun(X) -> X * X end, Input),
    lists:sort(SortedSquares).