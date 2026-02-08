%% -spec find_words(Board :: [[char()]], Words :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
find_words(Board, Words) ->
    Trie = build_trie(Words),
    lists:filter(fun(Word) -> search_word(Board, Word, Trie) end, Words).

%% Build a Trie from a list of words
-spec build_trie([unicode:unicode_binary()]) -> map.
build_trie(Words) ->
    lists:foldl(fun(Word, Trie) -> add_word_to_trie(Word, Trie) end, #{}, Words).

%% Add a word to the Trie
-spec add_word_to_trie(unicode:unicode_binary(), map) -> map.
add_word_to_trie(Word, Trie) ->
    lists:foldl(fun(Char, TrieAcc) -> 
                    case maps:get(Char, TrieAcc, #{}) of
                        #{} -> maps:put(Char, #{}, TrieAcc);
                        SubTrie -> maps:put(Char, SubTrie, TrieAcc)
                    end
                end, Trie, list:reverse(Word)).

%% Search a word in the board using backtracking
-spec search_word([[char()]], unicode:unicode_binary(), map) -> boolean().
search_word(Board, Word, Trie) ->
    search_word(Board, Word, Trie, 0, 0, #{}).

%% Search helper with backtracking
-spec search_word([[char()]], unicode:unicode_binary(), map, integer(), integer(), map) -> boolean().
search_word(_, [], _, _, _, _) -> true;
search_word(Board, [Char | Rest], Trie, Row, Col, Visited) ->
    case is_valid_move(Board, Row, Col, Char, Visited) of
        true ->
            NewVisited = maps:put({Row, Col}, true, Visited),
            case maps:get(Char, Trie, #{}) of
                SubTrie when maps:member({}, SubTrie) -> 
                    search_adjacent_cells(Board, Rest, SubTrie, Row, Col, NewVisited);
                _ -> false
            end;
        false -> false
    end.

%% Check if a move is valid on the board
-spec is_valid_move([[char()]], integer(), integer(), char(), map) -> boolean().
is_valid_move(Board, Row, Col, Char, Visited) ->
    Row >= 0 andalso Row < length(Board) andalso
    Col >= 0 andalso Col < length(hd(Board)) andalso
    not maps:member({Row, Col}, Visited) andalso
    lists:nth(Row + 1, Board):lists:nth(Col + 1, hd(Board)) == Char.

%% Search adjacent cells for backtracking
-spec search_adjacent_cells([[char()]], unicode:unicode_binary(), map, integer(), integer(), map) -> boolean().
search_adjacent_cells(Board, Rest, Trie, Row, Col, Visited) ->
    lists:any(fun({Dr, Dc}) ->
                    search_word(Board, Rest, Trie, Row + Dr, Col + Dc, Visited)
               end, [{1,0}, {-1,0}, {0,1}, {0,-1}]).
