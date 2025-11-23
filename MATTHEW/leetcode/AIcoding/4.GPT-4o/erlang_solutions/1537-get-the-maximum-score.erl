-module(solution).
-export([maximum_score/3]).

maximum_score(A, B, C) ->
    lists:max([element(1, A) + element(1, B) + element(1, C) - element(2, A) - element(2, B) - element(2, C)]).