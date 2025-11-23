-module(solution).
-export([sum_of_squares/1]).

sum_of_squares(List) ->
    SpecialElements = [X || {X, Index} <- lists:zip(List, lists:seq(1, length(List))), X rem Index == 0],
    lists:sum([X * X || X <- SpecialElements]).