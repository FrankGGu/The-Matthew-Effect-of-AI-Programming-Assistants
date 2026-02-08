-module(word_search_ii).
-export([findWords/2]).

findWords(Board, Words) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    Trie = buildTrie(Words),
    Found = gb_sets:empty(),
    findWordsHelper(Board, Rows, Cols, Trie, 0, 0, Found, []).

findWordsHelper(Board, Rows, Cols, Trie, Row, Col, Found, Acc) ->
    if Row >= Rows then
        gb_sets:to_list(Found)
    else
        if Col >= Cols then
            findWordsHelper(Board, Rows, Cols, Trie, Row + 1, 0, Found, Acc)
        else
            Char = lists:nth(Col + 1, lists:nth(Row + 1, Board)),
            case trie_lookup(Trie, Char) of
                undefined ->
                    findWordsHelper(Board, Rows, Cols, Trie, Row, Col + 1, Found, Acc);
                NextTrie ->
                    UpdatedFound = searchWord(Board, Rows, Cols, Row, Col, NextTrie, "", Found),
                    findWordsHelper(Board, Rows, Cols, Trie, Row, Col + 1, UpdatedFound, Acc)
            end
        end
    end.

searchWord(Board, Rows, Cols, Row, Col, Trie, Word, Found) ->
    if Row < 0 or Row >= Rows or Col < 0 or Col >= Cols then
        Found
    else
        Char = lists:nth(Col + 1, lists:nth(Row + 1, Board)),
        if Char =:= '_' then
            Found
        else
            case trie_lookup(Trie, Char) of
                undefined ->
                    Found;
                NextTrie ->
                    NewWord = Word ++ [Char],
                    case trie_lookup(NextTrie, '$') of
                        '$' ->
                            UpdatedFound = gb_sets:add_element(list_to_atom(NewWord), Found);
                        _ ->
                            UpdatedFound = Found
                    end,
                    OriginalChar = lists:nth(Col + 1, lists:nth(Row + 1, Board)),
                    Board1 = set_element(Board, Row + 1, set_element(lists:nth(Row + 1, Board), Col + 1, '_')),
                    Found1 = searchWord(Board1, Rows, Cols, Row + 1, Col, NextTrie, NewWord, UpdatedFound),
                    Found2 = searchWord(Board1, Rows, Cols, Row - 1, Col, NextTrie, NewWord, Found1),
                    Found3 = searchWord(Board1, Rows, Cols, Row, Col + 1, NextTrie, NewWord, Found2),
                    Found4 = searchWord(Board1, Rows, Cols, Row, Col - 1, NextTrie, NewWord, Found3),
                    Board2 = set_element(Board1, Row + 1, set_element(lists:nth(Row + 1, Board1), Col + 1, OriginalChar)),
                    Found4
            end
        end
    end.

buildTrie(Words) ->
    lists:foldl(fun(Word, Trie) -> insertWord(Trie, Word) end, trie_create(), Words).

insertWord(Trie, Word) ->
    insertWordHelper(Trie, string:to_list(Word)).

insertWordHelper(Trie, []) ->
    trie_insert(Trie, '$', '$');
insertWordHelper(Trie, [Char | Rest]) ->
    case trie_lookup(Trie, Char) of
        undefined ->
            NextTrie = trie_create(),
            Trie1 = trie_insert(Trie, Char, NextTrie),
            insertWordHelper(NextTrie, Rest),
            Trie1;
        NextTrie ->
            insertWordHelper(NextTrie, Rest),
            Trie
    end.

trie_create() ->
    dict:new().

trie_insert(Trie, Char, Value) ->
    dict:store(Char, Value, Trie).

trie_lookup(Trie, Char) ->
    case dict:find(Char, Trie) of
        {ok, Value} ->
            Value;
        error ->
            undefined
    end.