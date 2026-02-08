-module(solution).
-export([sort_students/1]).

sort_students(Students) ->
    lists:sort(fun(A, B) ->
        K = 2,
        lists:nth(K, A) =< lists:nth(K, B)
    end, Students).