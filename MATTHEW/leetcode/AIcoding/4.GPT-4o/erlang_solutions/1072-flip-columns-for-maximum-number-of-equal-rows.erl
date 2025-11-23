-module(solution).
-export([maxEqualRowsAfterFlips/1]).

maxEqualRowsAfterFlips(Matrix) ->
    Groups = lists:map(fun Row -> row_key(Row) end, Matrix),
    Counts = lists:foldl(fun(Key, Acc) -> maps:update_with(Key, fun(X) -> X + 1 end, 1, Acc) end, maps:new(), Groups),
    maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, Counts).

row_key(Row) ->
    First = hd(Row),
    lists:map(fun(X) -> X bxor First end, Row).