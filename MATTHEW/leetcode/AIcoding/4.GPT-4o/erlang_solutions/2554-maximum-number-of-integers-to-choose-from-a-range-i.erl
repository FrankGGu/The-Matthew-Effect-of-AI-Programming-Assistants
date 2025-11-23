-module(solution).
-export([maximum_integers/2]).

maximum_integers(N, L) ->
    lists:filter(fun(X) -> X >= L end, lists:seq(1, N)) |> length().