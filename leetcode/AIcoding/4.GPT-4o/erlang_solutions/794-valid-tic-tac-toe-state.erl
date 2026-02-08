-module(solution).
-export([valid_tic_tac_toe/1]).

valid_tic_tac_toe(Board) ->
    Counts = counts(Board),
    XWins = check_win(Board, $X),
    OWins = check_win(Board, $O),
    (Counts#count.x >= Counts#count.o, Counts#count.x - Counts#count.o =< 1) andalso
    (not (XWins andalso OWins)) andalso
    (not (XWins andalso Counts#count.x =< Counts#count.o)) andalso
    (not (OWins andalso Counts#count.x > Counts#count.o)).

-record(count, {x = 0, o = 0}).

counts(Board) ->
    lists:foldl(fun(Char, Acc) ->
        case Char of
            $X -> Acc#count{x = Acc#count.x + 1};
            $O -> Acc#count{o = Acc#count.o + 1};
            _ -> Acc
        end
    end, #count{}, Board).

check_win(Board, Player) ->
    Rows = [lists:sublist(Board, 1, 3),
            lists:sublist(Board, 4, 3),
            lists:sublist(Board, 7, 3)],
    Cols = [lists:seq(1, 3) ++ [0], lists:seq(4, 6) ++ [0], lists:seq(7, 9) ++ [0]],
    Diags = [[1, 5, 9], [3, 5, 7]],
    WinningLines = Rows ++ [lists:nth(1, Cols), lists:nth(2, Cols), lists:nth(3, Cols)] ++ Diags,
    lists:any(fun(Line) -> lists:all(fun(Index) -> lists:nth(Index, Board) =:= Player end, Line) end, WinningLines).