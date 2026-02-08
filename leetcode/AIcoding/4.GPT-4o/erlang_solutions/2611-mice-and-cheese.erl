-module(solution).
-export([miceAndCheese/2]).

miceAndCheese(Mice, Cheese) ->
    lists:sum(lists:map(fun({M, C}) -> M + C end, lists:zip(Mice, Cheese))) - 
    lists:sum(lists:sort(fun(A, B) -> A > B end, lists:zip(Mice, Cheese))).