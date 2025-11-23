%% Define the WordDictionary using a trie structure
-record(word_dictionary, {trie = #{}}).

-spec word_dictionary_init_() -> #word_dictionary{}.
word_dictionary_init_() -> 
    #word_dictionary{trie = #{}}.

-spec word_dictionary_add_word(Word :: unicode:unicode_binary(), Dictionary :: #word_dictionary{}) -> #word_dictionary{}.
word_dictionary_add_word(Word, #word_dictionary{trie = Trie}) ->
    NewTrie = add_word_to_trie(Word, Trie),
    #word_dictionary{trie = NewTrie}.

-spec word_dictionary_search(Word :: unicode:unicode_binary(), Dictionary :: #word_dictionary{}) -> boolean().
word_dictionary_search(Word, #word_dictionary{trie = Trie}) ->
    search_word_in_trie(Word, Trie).

add_word_to_trie(Word, Trie) ->
    lists:foldl(fun(Char, Acc) -> 
                    case maps:get(Char, Acc, undefined) of
                        undefined -> maps:put(Char, #{}, Acc);
                        _ -> Acc
                    end
                end, Trie, string:to_list(Word)).

search_word_in_trie(Word, Trie) ->
    search_word(Word, Trie).

search_word([], _Trie) -> true;
search_word([Dot | Rest], Trie) when Dot =:= $. -> 
    lists:any(fun(Child) -> search_word(Rest, maps:get(Child, Trie, %{})) end, maps:keys(Trie));
search_word([Char | Rest], Trie) -> 
    case maps:get(Char, Trie, undefined) of
        undefined -> false;
        ChildTrie -> search_word(Rest, ChildTrie)
    end.
