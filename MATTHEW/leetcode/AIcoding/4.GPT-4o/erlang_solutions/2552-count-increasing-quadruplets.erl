-module(solution).
-export([countQuadruplets/1]).

countQuadruplets(List) ->
    N = length(List),
    QuadrupletCount = fun(N) ->
        lists:foldl(fun(X, Acc) ->
            lists:foldl(fun(Y, Acc1) ->
                Acc1 + lists:foldl(fun(Z, Acc2) ->
                    Acc2 + lists:foldl(fun(W, Acc3) ->
                        if
                            W > Z, Z > Y, Y > X -> 1;
                            true -> 0
                        end + Acc3
                    end, Acc2, lists:sublist(List, Z+1, N - Z - 1))
                end, Acc1, lists:sublist(List, Y+1, N - Y - 1))
            end, Acc, lists:sublist(List, X+1, N - X - 1))
        end, 0, lists:sublist(List, 0, N - 3))
    end(N),
    QuadrupletCount.