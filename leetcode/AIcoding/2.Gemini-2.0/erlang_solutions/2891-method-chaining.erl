-module(method_chaining).
-export([solve/1]).

solve(N) ->
  lists:seq(1, N)
  |> lists:map(fun(X) -> X * 2 end)
  |> lists:filter(fun(X) -> X rem 3 == 0 end)
  |> lists:sum().