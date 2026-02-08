-module(transform_to_chessboard).
-export([valid_square/1]).

valid_square(Board) ->
    N = length(Board),
    Valid = fun(Row, IsRow) ->
        case IsRow of
            true ->
                case Row of
                    [H|_] -> H == 0;
                    _ -> false
                end;
            false ->
                case Row of
                    [H|_] -> H == 1;
                    _ -> false
                end
        end
    end,
    Count = lists:foldl(fun(Row, Acc) ->
        case Valid(Row, true) of
            true -> Acc + 1;
            _ -> Acc
        end
    end, 0, Board),
    if
        Count == N -> valid_board(Board, N, 0);
        true -> false
    end.

valid_board([], _, _) -> true;
valid_board([Row|Rest], N, Index) ->
    case is_valid_row(Row, Index, N) of
        true -> valid_board(Rest, N, Index + 1);
        false -> false
    end.

is_valid_row([], _, _) -> true;
is_valid_row([H|T], Index, N) ->
    case (Index + H) rem 2 of
        0 -> is_valid_row(T, Index + 1, N);
        _ -> false
    end.