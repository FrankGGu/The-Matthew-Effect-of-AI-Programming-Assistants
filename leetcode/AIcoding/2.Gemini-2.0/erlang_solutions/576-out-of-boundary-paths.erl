-module(out_of_boundary_paths).
-export([find_paths/4]).

find_paths(M, N, MaxMove, StartRow, StartColumn) ->
    find_paths(M, N, MaxMove, StartRow, StartColumn, #{}).

find_paths(M, N, 0, _Row, _Column, _Memo) ->
    0;
find_paths(M, N, MaxMove, Row, Column, Memo) ->
    case maps:get({MaxMove, Row, Column}, Memo, undefined) of
        undefined ->
            Result =
                (case Row =:= -1 of true -> 1; false -> 0 end) +
                (case Row =:= M of true -> 1; false -> 0 end) +
                (case Column =:= -1 of true -> 1; false -> 0 end) +
                (case Column =:= N of true -> 1; false -> 0 end) +
                (case Row >= 0 andalso Row < M andalso Column >= 0 andalso Column < N of
                    true ->
                        (find_paths(M, N, MaxMove - 1, Row - 1, Column, Memo) +
                         find_paths(M, N, MaxMove - 1, Row + 1, Column, Memo) +
                         find_paths(M, N, MaxMove - 1, Row, Column - 1, Memo) +
                         find_paths(M, N, MaxMove - 1, Row, Column + 1, Memo)) rem 1000000007;
                    false ->
                        0
                end),
            NewMemo = maps:put({MaxMove, Row, Column}, Result, Memo),
            NewMemo2 = maps:put({MaxMove, Row, Column}, Result rem 1000000007, NewMemo),
            Result rem 1000000007;
        Value ->
            Value
    end.