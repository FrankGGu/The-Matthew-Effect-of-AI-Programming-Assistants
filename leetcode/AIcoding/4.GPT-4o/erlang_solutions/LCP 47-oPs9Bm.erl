-module(solution).
-export([check_security/1]).

check_security(Arr) ->
    lists:foldl(fun(X, Acc) -> Acc + (if X > 0 -> 1; true -> -1 end) end, 0, Arr) =:= 0.