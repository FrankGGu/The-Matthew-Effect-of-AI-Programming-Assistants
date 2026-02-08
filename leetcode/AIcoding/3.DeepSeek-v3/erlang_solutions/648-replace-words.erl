-module(replace_words).
-export([replace_words/2]).

replace_words(Dict, Sentence) ->
    Words = string:tokens(Sentence, " "),
    Trie = build_trie(Dict),
    Replaced = lists:map(fun(Word) -> replace_word(Trie, Word) end, Words),
    string:join(Replaced, " ").

build_trie(Dict) ->
    lists:foldl(fun(Word, Trie) -> insert_word(Trie, Word) end, dict:new(), Dict).

insert_word(Trie, Word) ->
    lists:foldl(fun(Char, T) -> 
        dict:append(Char, T, dict:new()) 
    end, Trie, Word).

replace_word(Trie, Word) ->
    case find_root(Trie, Word, []) of
        {ok, Root} -> Root;
        error -> Word
    end.

find_root(_Trie, [], _Acc) -> error;
find_root(Trie, [Char | Rest], Acc) ->
    case dict:find(Char, Trie) of
        {ok, SubTrie} -> 
            NewAcc = Acc ++ [Char],
            case dict:is_empty(SubTrie) of
                true -> {ok, NewAcc};
                false -> find_root(SubTrie, Rest, NewAcc)
            end;
        error -> error
    end.