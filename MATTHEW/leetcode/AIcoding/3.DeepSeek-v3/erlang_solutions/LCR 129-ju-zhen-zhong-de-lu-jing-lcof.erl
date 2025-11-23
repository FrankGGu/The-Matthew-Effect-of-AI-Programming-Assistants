-spec exist(Board :: [[char()]], Word :: unicode:unicode_binary()) -> boolean().
exist(Board, Word) ->
    case Board of
        [] -> false;
        _ ->
            M = length(Board),
            N = length(hd(Board)),
            WordList = unicode:characters_to_list(Word),
            lists:any(fun(I) ->
                lists:any(fun(J) ->
                    dfs(Board, WordList, I, J, 0, M, N, sets:new())
                end, lists:seq(0, N - 1))
            end, lists:seq(0, M - 1))
    end.

dfs(_, [], _, _, _, _, _, _) -> true;
dfs(Board, [H|T], I, J, _, M, N, Visited) ->
    case I >= 0 andalso I < M andalso J >= 0 andalso J < N of
        true ->
            case lists:nth(I + 1, Board) of
                Row when is_list(Row) ->
                    case lists:nth(J + 1, Row) of
                        H ->
                            case sets:is_element({I, J}, Visited) of
                                false ->
                                    NewVisited = sets:add_element({I, J}, Visited),
                                    dfs(Board, T, I + 1, J, 0, M, N, NewVisited) orelse
                                    dfs(Board, T, I - 1, J, 0, M, N, NewVisited) orelse
                                    dfs(Board, T, I, J + 1, 0, M, N, NewVisited) orelse
                                    dfs(Board, T, I, J - 1, 0, M, N, NewVisited);
                                true -> false
                            end;
                        _ -> false
                    end;
                _ -> false
            end;
        false -> false
    end.