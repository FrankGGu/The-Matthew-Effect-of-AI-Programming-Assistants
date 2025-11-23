-module(diagonal_traverse_ii).
-export([find_diagonal_order/1]).

find_diagonal_order(Nums) ->
    {Rows, Cols} = lists:foldl(fun(Row, {R, C}) ->
                                       {R + 1, max(C, length(Row))}
                                   end, {0, 0}, Nums),
    Map = lists:foldl(fun({RowIndex, Row}, Acc) ->
                               lists:foldl(fun({ColIndex, Value}, Acc2) ->
                                                   maps:put({RowIndex, ColIndex}, Value, Acc2)
                                           end, Acc, lists:zip(lists:seq(0, length(Row) - 1), Row))
                       end, maps:new(), lists:zip(lists:seq(0, Rows - 1), Nums)),

    Result = lists:foldl(fun(DiagonalIndex, Acc) ->
                               lists:foldl(fun(RowIndex, Acc2) ->
                                                   ColIndex = DiagonalIndex - RowIndex,
                                                   case maps:is_key({RowIndex, ColIndex}, Map) of
                                                       true ->
                                                           [maps:get({RowIndex, ColIndex}, Map) | Acc2];
                                                       false ->
                                                           Acc2
                                                   end
                                           end, Acc, lists:seq(0, DiagonalIndex))
                           end, [], lists:seq(0, Rows + Cols - 2)),
    lists:reverse(Result).