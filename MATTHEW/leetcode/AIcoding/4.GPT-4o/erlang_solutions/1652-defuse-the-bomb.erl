-module(solution).
-export([defuse_bomb/2]).

defuse_bomb(code, k) ->
    lists:map(fun(X) -> (X + k) rem 60 end, code).