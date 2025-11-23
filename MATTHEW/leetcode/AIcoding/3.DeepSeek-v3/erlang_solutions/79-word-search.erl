-spec exist(Board :: [[char()]], Word :: unicode:unicode_binary()) -> boolean().
exist(Board, Word) ->
    case Word of
        <<>> -> true;
        _ ->
            WordList = unicode:characters_to_list(Word),
            {Rows, Cols} = {length(Board), length(hd(Board))},
            lists:any(fun(I) ->
                lists:any(fun(J) ->
                    dfs(Board, WordList, I, J, 0, Rows, Cols)
                end, lists:seq(0, Cols - 1))
            end, lists:seq(0, Rows - 1))
    end.

dfs(Board, Word, I, J, Index, Rows, Cols) ->
    case Index =:= length(Word) of
        true -> true;
        false ->
            case (I >= 0) andalso (I < Rows) andalso (J >= 0) andalso (J < Cols) of
                false -> false;
                true ->
                    case lists:nth(I + 1, Board) of
                        Row when is_list(Row) ->
                            Char = lists:nth(J + 1, Row),
                            case Char =:= lists:nth(Index + 1, Word) of
                                false -> false;
                                true ->
                                    NewBoard = mark_visited(Board, I, J),
                                    dfs(NewBoard, Word, I + 1, J, Index + 1, Rows, Cols) orelse
                                    dfs(NewBoard, Word, I - 1, J, Index + 1, Rows, Cols) orelse
                                    dfs(NewBoard, Word, I, J + 1, Index + 1, Rows, Cols) orelse
                                    dfs(NewBoard, Word, I, J - 1, Index + 1, Rows, Cols)
                            end
                    end
            end
    end.

mark_visited(Board, I, J) ->
    Row = lists:nth(I + 1, Board),
    NewRow = lists:sublist(Row, J) ++ [0] ++ lists:nthtail(J + 1, Row),
    lists:sublist(Board, I) ++ [NewRow] ++ lists:nthtail(I + 1, Board).