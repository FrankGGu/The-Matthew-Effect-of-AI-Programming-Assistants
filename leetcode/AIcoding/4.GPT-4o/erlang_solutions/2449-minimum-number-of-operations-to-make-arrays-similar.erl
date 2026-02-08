-module(solution).
-export([min_operations/2]).

min_operations(A, B) ->
    SortedA = lists:sort(A),
    SortedB = lists:sort(B),
    {SumA, SumB} = lists:foldl(fun(X, {AccA, AccB}) -> {AccA + X, AccB + X} end, {0, 0}, SortedA),
    DiffA = lists:map(fun(X) -> X - SumA div length(SortedA) end, SortedA),
    DiffB = lists:map(fun(X) -> X - SumB div length(SortedB) end, SortedB),
    lists:sum(lists:map(fun(X) -> abs(X) end, lists:zipwith(fun(X, Y) -> X - Y end, DiffA, DiffB))) div 2.