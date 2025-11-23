-module(solution).
-export([tictactoe/1]).

tictactoe(Board) ->
    case check_winner(Board) of
        none -> "Draw";
        Winner -> Winner
    end.

check_winner(Board) ->
    Rows = Board,
    Cols = lists:transpose(Board),
    Diags = [[lists:nth(1, Board), lists:nth(2, lists:nth(2, Board)), lists:nth(3, lists:nth(3, Board))],
             [lists:nth(3, Board), lists:nth(2, lists:nth(2, Board)), lists:nth(1, lists:nth(3, Board))]],
    check_lines(Rows) orelse check_lines(Cols) orelse check_lines(Diags).

check_lines(Lines) ->
    lists:foldl(fun(Line, Acc) ->
        case Acc of
            none ->
                case lists:uniq(Line) of
                    [X] when X =/= " " -> X;
                    _ -> none
                end;
            _ -> Acc
        end
    end, none, Lines).