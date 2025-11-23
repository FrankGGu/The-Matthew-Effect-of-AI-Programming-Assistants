-module(solution).
-export([moves_to_chessboard/1]).

moves_to_chessboard(Board) ->
    N = length(Board),
    Rows = lists:map(fun(X) -> lists:sum(X) end, Board),
    Cols = lists:map(fun(X) -> lists:sum(lists:nth(X, Board)) end, lists:seq(1, N)),
    if
        Rows rem 2 =:= 0 -> 
            Rows1 = Rows div 2,
            lists:all(fun(X) -> X =:= Rows1 end, Rows)
        ;
        true -> 
            lists:all(fun(X) -> X =:= Rows div 2 orelse X =:= (Rows div 2) + 1 end, Rows)
    end,
    if
        lists:all(fun(X) -> X rem 2 =:= 0 end, Cols) orelse lists:all(fun(X) -> X rem 2 =:= 1 end, Cols) ->
            case count_swaps(Board, 0, 0) of
                {ok, R} -> R;
                _ -> -1
            end;
        true -> -1
    end.

count_swaps([], _, _) -> {ok, 0};
count_swaps([Row | Rows], 0, Count) ->
    count_swaps(Rows, Row, Count + count_row_swaps(Row, 0));
count_swaps([Row | Rows], LastRow, Count) ->
    if 
        Row =:= LastRow -> count_swaps(Rows, LastRow, Count);
        true -> {error, Count}
    end.

count_row_swaps(Row, Count) ->
    Target = (lists:sum(Row) * 2) div length(Row),
    lists:map(fun(X) -> if X =:= 1 -> 1; true -> 0 end end, Row) ++ 
    lists:map(fun(X) -> if X =:= 0 -> 1; true -> 0 end end, Row) 
    |> lists:foldl(fun(X, Acc) -> Acc + X end, 0) - Target.