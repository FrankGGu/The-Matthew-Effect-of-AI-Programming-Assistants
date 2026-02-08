-module(solution).
-export([sort_parity/1]).

sort_parity(Arr) ->
    {Even, Odd} = lists:partition(fun(X) -> X rem 2 == 0 end, Arr),
    Even ++ Odd.