-module(solution).
-export([sum_multiples/1]).

sum_multiples(N) ->
    lists:sum(lists:filter(fun(X) -> X rem 3 =:= 0 orelse X rem 5 =:= 0 orelse X rem 7 =:= 0 end, lists:seq(1, N))).