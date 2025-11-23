-module(solution).
-export([countSquareFreeSubsets/1]).

countSquareFreeSubsets(N) ->
    Mod = 1000000007,
    Squares = [X * X || X <- lists:seq(1, trunc(math:sqrt(N)))],
    SquareFreeCount = fun(N, 0, _) -> 1;
                        (N, K, Squares) when K < 0 -> 0;
                        (N, K, Squares) -> 
                            case Squares of
                                [] -> 1;
                                [S | Rest] ->
                                    SquareFreeCount(N, K, Rest) + 
                                    SquareFreeCount(N, K - S, Squares)
                            end
                        end,
    SquareFreeCount(N, N, Squares) rem Mod.