-module(sort_array_by_parity).
-export([sort_array_by_parity/1]).

sort_array_by_parity(A) ->
  lists:partition(fun(X) -> (X rem 2) == 0 end, A).