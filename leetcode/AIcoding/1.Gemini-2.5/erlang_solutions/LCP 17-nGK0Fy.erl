-module(solution).
-export([calculate/2]).

-spec calculate(X :: integer(), Nums :: [integer()]) -> integer().
calculate(X, Nums) ->
    lists:foldl(fun(Op, CurrentX) ->
                    if
                        Op == 0 ->
                            2 * CurrentX + 1;
                        Op == 1 ->
                            2 * CurrentX
                    end
                end, X, Nums).