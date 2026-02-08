-module(sol).
-export([count_special_quadruplets/1]).

count_special_quadruplets(List) ->
    N = length(List),
    Count = lists:foldl(fun(X, Acc) ->
        Acc + lists:foldl(fun(Y, Acc1) ->
            Acc1 + lists:foldl(fun(Z, Acc2) ->
                Acc2 + lists:foldl(fun(W, Acc3) ->
                    if
                        X + Y + Z == W -> Acc3 + 1;
                        true -> Acc3
                    end
                end, Acc2, lists:nthtail(Z + 1, List))
            end, Acc1, lists:nthtail(Y + 1, List))
        end, Acc, lists:nthtail(X + 1, List))
    end, 0, lists:seq(1, N - 1)),
    Count.