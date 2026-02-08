-module(tictactoe).
-export([is_winner/2]).

is_winner(Moves, Player) ->
    Board = lists:foldl(fun({X,Y}, Acc) -> set_cell(Acc, X, Y, Player) end, init_board(), Moves),
    check_winner(Board).

init_board() ->
    [[0,0,0],[0,0,0],[0,0,0]].

set_cell(Board, X, Y, Value) ->
    Row = lists:nth(X+1, Board),
    NewRow = lists:sublist(Row, Y) ++ [Value] ++ lists:sublist(Row, Y+1, 3-Y),
    lists:sublist(Board, X) ++ [NewRow] ++ lists:sublist(Board, X+1, 3-X).

check_winner(Board) ->
    case check_rows(Board) of
        true -> true;
        _ -> case check_cols(Board) of
                true -> true;
                _ -> case check_diag(Board) of
                        true -> true;
                        _ -> false
                    end
            end
    end.

check_rows(Board) ->
    lists:any(fun(Row) -> lists:all(fun(E) -> E == hd(Row) end, Row) andalso hd(Row) /= 0 end, Board).

check_cols(Board) ->
    lists:any(fun(Col) -> lists:all(fun(E) -> E == hd(Col) end, Col) andalso hd(Col) /= 0 end, transpose(Board)).

check_diag(Board) ->
    D1 = [lists:nth(I+1, lists:nth(I+1, Board)) || I <- lists:seq(0,2)],
    D2 = [lists:nth(3-I, lists:nth(I+1, Board)) || I <- lists:seq(0,2)],
    (lists:all(fun(E) -> E == hd(D1) end, D1) andalso hd(D1) /= 0) orelse (lists:all(fun(E) -> E == hd(D2) end, D2) andalso hd(D2) /= 0).

transpose([[]|_]) -> [];
transpose(Lists) ->
    [lists:map(fun hd/1, Lists) | transpose(lists:map(fun tl/1, Lists))].