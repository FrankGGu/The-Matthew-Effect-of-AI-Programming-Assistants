-module(diagonal_traverse).
-export([find_diagonal_order/1]).

find_diagonal_order(Nums) ->
    DiagMap = build_diag_map(Nums, 0, 0, #{}),
    Keys = maps:keys(DiagMap),
    lists:sort(Keys),
    lists:flatmap(fun(Key) -> lists:reverse(maps:get(Key, DiagMap)) end, lists:sort(Keys)).

build_diag_map([], _, _, Acc) ->
    Acc;
build_diag_map([Row | Rest], RowIdx, ColIdx, Acc) ->
    build_diag_map(Row, RowIdx, ColIdx, Acc, Row),
    build_diag_map(Rest, RowIdx + 1, 0, Acc).

build_diag_map([], _, _, Acc, _) ->
    Acc;
build_diag_map([Val | Rest], RowIdx, ColIdx, Acc, Row) ->
    Key = RowIdx + ColIdx,
    NewValue = [Val | maps:get(Key, Acc, [])],
    NewAcc = maps:put(Key, NewValue, Acc),
    build_diag_map(Rest, RowIdx, ColIdx + 1, NewAcc, Row).