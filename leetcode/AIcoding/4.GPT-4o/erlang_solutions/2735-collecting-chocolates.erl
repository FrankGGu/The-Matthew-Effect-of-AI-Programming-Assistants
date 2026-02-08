-module(solution).
-export([collectChocolate/2]).

collectChocolate(N, K) ->
    lists:sum(lists:duplicate(N, K)).