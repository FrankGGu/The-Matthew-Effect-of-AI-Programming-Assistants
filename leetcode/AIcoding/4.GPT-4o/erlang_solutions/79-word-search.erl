%% -spec exist(Board :: [[char()]], Word :: unicode:unicode_binary()) -> boolean().
exist(Board, Word) ->
    lists:foldl(fun(Row, Acc) -> 
                    case search_word(Row, Word, Board) of
                        true -> true;
                        false -> Acc
                    end
                end, false, Board).

%% Helper function to search the word in the grid
-spec search_word(Row :: [char()], Word :: unicode:unicode_binary(), Board :: [[char()]]) -> boolean().
search_word(Row, Word, Board) ->
    case lists:prefix(Word, Row) of
        true -> true;
        false -> search_adjacent(Board, Word, 0, 0)
    end.

-spec search_adjacent(Board :: [[char()]], Word :: unicode:unicode_binary(), X :: integer(), Y :: integer()) -> boolean().
search_adjacent(Board, Word, X, Y) ->
    %% Implement DFS or backtracking for word search in grid
    false.
