-module(solution).
-export([solve/1]).

solve(Board) ->
    M = length(Board),
    case M of
        0 -> [];
        _ ->
            N = length(hd(Board)),
            case N of
                0 -> [];
                _ ->
                    MarkedBoard = mark_borders(Board, M, N),
                    finalize_board(MarkedBoard)
            end
    end.

mark_borders(Board, M, N) ->
    BoardAcc = Board,
    BoardAcc1 = lists:foldl(fun(C, Acc) ->
                                maybe_dfs(0, C, Acc, M, N)
                            end, BoardAcc, lists:seq(0, N - 1)),
    BoardAcc2 = lists:foldl(fun(C, Acc) ->
                                maybe_dfs(M - 1, C, Acc, M, N)
                            end, BoardAcc1, lists:seq(0, N - 1)),
    BoardAcc3 = lists:foldl(fun(R, Acc) ->
                                maybe_dfs(R, 0, Acc, M, N)
                            end, BoardAcc2, lists:seq(1, M - 2)),
    lists:foldl(fun(R, Acc) ->
                    maybe_dfs(R, N - 1, Acc, M, N)
                end, BoardAcc3, lists:seq(1, M - 2)).

maybe_dfs(R, C, Board, M, N) ->
    case get_char(R, C, Board) of
        'O' -> dfs(R, C, Board, M, N);
        _ -> Board
    end.

dfs(R, C, Board, M, N) ->
    if
        R < 0 orelse R >= M orelse C < 0 orelse C >= N ->
            Board;
        true ->
            case get_char(R, C, Board) of
                'O' ->
                    Board1 = set_char(R, C, $$, Board),
                    Board2 = dfs(R + 1, C, Board1, M, N),
                    Board3 = dfs(R - 1, C, Board2, M, N),
                    Board4 = dfs(R, C + 1, Board3, M, N),
                    dfs(R, C - 1, Board4, M, N);
                _ ->
                    Board
            end
    end.

get_char(R, C, Board) ->
    lists:nth(C + 1, lists:nth(R + 1, Board)).

set_char(R, C, Char, Board) ->
    lists:replace_at(R + 1, lists:replace_at(C + 1, Char, lists:nth(R + 1, Board)), Board).

finalize_board(Board) ->
    lists:map(fun(RowList) ->
                lists:map(fun(Char) ->
                            case Char of
                                'O' -> 'X';
                                '$' -> 'O';
                                _ -> Char
                            end
                        end, RowList)
            end, Board).