-module(word_search_ii).
-export([find_words/1]).

find_words(Board) ->
    Words = ["o","aa","aaa","aaaa","aaaaa","aaaaaa","aaaaaaa","aaaaaaaa","aaaaaaaaa","aaaaaaaaaa"],
    Trie = build_trie(Words),
    Rows = length(Board),
    Cols = length(hd(Board)),
    Results = [],
    find_words(Board, 0, 0, Trie, Results, Rows, Cols).

find_words(_, _, C, _, Results, _, Cols) when C == Cols ->
    find_words(_, R, 0, _, Results, R + 1, Cols);
find_words(_, R, C, _, Results, Rows, _) when R == Rows ->
    Results;
find_words(Board, R, C, Trie, Results, Rows, Cols) ->
    Char = lists:nth(C+1, lists:nth(R+1, Board)),
    case get_child(Trie, Char) of
        false -> 
            find_words(Board, R, C+1, Trie, Results, Rows, Cols);
        NextTrie ->
            case is_end_of_word(NextTrie) of
                true -> 
                    NewResults = [Char | Results],
                    find_words(Board, R, C+1, Trie, NewResults, Rows, Cols);
                false ->
                    find_words(Board, R, C+1, Trie, Results, Rows, Cols)
            end
    end.

build_trie(Words) ->
    Trie = {dict, dict:new()},
    lists:foreach(fun(Word) -> insert_word(Trie, Word) end, Words),
    Trie.

insert_word(Trie, Word) ->
    insert_word(Trie, Word, 0).

insert_word(Trie, [], _) ->
    dict:store('$', true, Trie);
insert_word(Trie, [H|T], Index) ->
    Child = get_child(Trie, H),
    if
        Child == false ->
            NewChild = {dict, dict:new()},
            dict:store(H, NewChild, Trie);
        true ->
            Child
    end,
    insert_word(Child, T, Index + 1).

get_child({dict, D}, Char) ->
    case dict:is_key(Char, D) of
        true -> dict:fetch(Char, D);
        false -> false
    end.

is_end_of_word({dict, D}) ->
    dict:is_key('$', D).