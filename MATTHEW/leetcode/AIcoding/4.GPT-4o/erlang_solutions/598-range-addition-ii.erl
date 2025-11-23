-module(solution).
-export([maxCount/3]).

maxCount(M, N, ops) ->
    Matrix = lists:duplicate(M, lists:duplicate(N, 0)),
    lists:foldl(fun({a, b}, Acc) ->
        lists:foldl(fun(X, Acc1) ->
            lists:foldl(fun(Y, Acc2) ->
                lists:update_element(X + 1, lists:update_element(Y + 1, Acc1, 1), Acc2)
            end, Acc1, lists:seq(1, b))
        end, Acc, lists:seq(1, a))
    end, Matrix, ops),
    Max = lists:max(lists:map(fun(Row) -> lists:max(Row) end, Matrix)),
    lists:sum(lists:map(fun(Row) -> lists:count(Row, Max) end, Matrix)).