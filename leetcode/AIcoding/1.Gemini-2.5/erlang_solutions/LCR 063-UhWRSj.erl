-module(solution).
-export([replace_words/2]).

replace_words(Dictionary, Sentence) ->
    %% 1. Build the Trie from the dictionary.
    Trie = build_trie(Dictionary),

    %% 2. Split the sentence into words.
    SentenceWords = string:tokens(Sentence, " "),

    %% 3. Process each word in the sentence.
    ReplacedWords = [replace_word(Word, Trie) || Word <- SentenceWords],

    %% 4. Join the processed words back into a string.
    string:join(ReplacedWords, " ").

build_trie(Dictionary) ->
    %% Initialize the root of the Trie.
    Root = #{children => #{}, is_end => false},
    %% Fold over the dictionary words to insert them into the Trie.
    lists:foldl(fun insert_word_into_trie/2, Root, Dictionary).

insert_word_into_trie(Word, Trie) ->
    insert_word_into_trie_recursive(Word, Trie).

insert_word_into_trie_recursive([], TrieNode) ->
    %% Mark the current node as the end of a word.
    TrieNode#{is_end => true};
insert_word_into_trie_recursive([H|T], TrieNode) ->
    Children = maps:get(children, TrieNode),
    %% Get the child node for the current character H. If it doesn't exist, create a new one.
    ChildNode = maps:get(H, Children, #{children => #{}, is_end => false}),
    %% Recursively insert the rest of the word into the child node.
    UpdatedChildNode = insert_word_into_trie_recursive(T, ChildNode),
    %% Update the children map with the modified child node.
    UpdatedChildren = maps:put(H, UpdatedChildNode, Children),
    %% Return the current node with its updated children map.
    TrieNode#{children => UpdatedChildren}.

replace_word(Word, Trie) ->
    %% Attempt to find the shortest root for the given word in the Trie.
    case find_shortest_root(Word, Trie) of
        false ->
            %% If no root is found, keep the original word.
            Word;
        Root ->
            %% If a root is found, replace the word with the root.
            Root
    end.

find_shortest_root(Word, TrieRoot) ->
    %% Start the recursive search for the shortest root.
    %% AccPrefix is used to build the prefix in reverse for efficiency.
    find_shortest_root_recursive(Word, TrieRoot, []).

find_shortest_root_recursive([], _CurrentNode, _AccPrefix) ->
    %% Reached the end of the word, but no root was marked along the path.
    false;
find_shortest_root_recursive([H|T], CurrentNode, AccPrefix) ->
    Children = maps:get(children, CurrentNode),
    %% Check if the current character H exists in the children of the current Trie node.
    case maps:find(H, Children) of
        {ok, NextNode} ->
            %% Prepend the current character to the accumulator.
            NewAccPrefix = [H|AccPrefix],
            %% If the NextNode marks the end of a word, this is the shortest root found so far.
            %% Since we traverse character by character, the first 'is_end' we hit is the shortest.
            if maps:get(is_end, NextNode) ->
                lists:reverse(NewAccPrefix); %% Reverse the accumulated prefix to get the root.
            true ->
                %% Continue searching with the rest of the word and the next node.
                find_shortest_root_recursive(T, NextNode, NewAccPrefix)
            end;
        error ->
            %% No path in the Trie for the current character, so no root can be formed.
            false
    end.