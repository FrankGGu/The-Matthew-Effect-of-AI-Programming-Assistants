-module(solution).
-export([solve/1]).

solve(magic) ->
    lists:foldl(fun(X, Acc) ->
                        case Acc >= X of
                            true -> Acc - X;
                            false -> -1
                        end
                    end, lists:max(magic), magic).