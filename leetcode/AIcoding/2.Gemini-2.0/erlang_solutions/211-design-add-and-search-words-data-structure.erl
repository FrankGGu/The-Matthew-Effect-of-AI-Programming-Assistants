-module(word_dictionary).
-export([new/0, add_word/2, search/2]).

new() ->
    #trie{}.

add_word(Word, Trie) ->
    add_word(Word, Trie, 1).

add_word([], Trie, _) ->
    Trie#trie{is_word = true};
add_word([H|T], Trie, _) ->
    Next = maps:get(H, Trie#trie.children, #trie{}),
    NewNext = add_word(T, Next, 1),
    NewChildren = maps:put(H, NewNext, Trie#trie.children),
    Trie#trie{children = NewChildren}.

search(Word, Trie) ->
    search(Word, Trie, 1).

search([], Trie, _) ->
    Trie#trie.is_word;
search([H|T], Trie, _) ->
    case H of
        '.' ->
            lists:any(fun(Child) ->
                              search(T, Child, 1)
                      end, maps:values(Trie#trie.children));
        _ ->
            case maps:get(H, Trie#trie.children, false) of
                false ->
                    false;
                Next ->
                    search(T, Next, 1)
            end
    end.

-record(trie, {children = #{}, is_word = false}).