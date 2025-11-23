-module(sum_multiples).
-export([sum_multiples/2]).

sum_multiples(N, Multiples) ->
  lists:sum([X || X <- lists:seq(1, N), lists:any(fun(M) -> X rem M == 0 end, Multiples)]).