-module(solution).
-export([delete_greatest_value/1]).

delete_greatest_value(Matrix) ->
    lists:map(fun(Row) -> lists:foldl(fun(X, Acc) -> lists:max([X | Acc]) end, [], Row) end, Matrix).