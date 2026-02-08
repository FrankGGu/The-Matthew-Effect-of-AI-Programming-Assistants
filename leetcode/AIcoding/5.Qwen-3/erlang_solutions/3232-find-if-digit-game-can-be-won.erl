-module(solution).
-export([can_win/1]).

can_win(Nums) ->
    lists:all(fun(X) -> X rem 2 == 0 end, Nums).