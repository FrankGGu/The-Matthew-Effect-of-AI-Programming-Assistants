-module(replace_words).
-export([replaceWords/2]).

replaceWords(Dict, Sentence) ->
    Trie = build_trie(Dict),
    Words = string:tokens(Sentence, " "),
    ReplacedWords = [find_replacement(Trie, Word) || Word <- Words],
    string:join(ReplacedWords, " ").

build_trie(Dict) ->
    InitialTrie = #{is_word => false, children => #{}},
    lists:foldl(fun add_word_to_trie/2, InitialTrie, Dict).

add_word_to_trie(Word, Trie) ->
    add_word_to_trie_recursive(Word, Trie).

add_word_to_trie_recursive([], Node) ->
    % Mark this node as the end of a word (a root)
    maps:put(is_word, true, Node);
add_word_to_trie_recursive([Char|Rest], Node) ->
    Children = maps:get(children, Node),
    case maps:find(Char, Children) of
        {ok, ChildNode} ->
            % Child exists, recurse and update it
            NewChildNode = add_word_to_trie_recursive(Rest, ChildNode),
            maps:put(children, maps:put(Char, NewChildNode, Children), Node);
        undefined ->
            % Child does not exist, create a new node and recurse
            NewChildNode = add_word_to_trie_recursive(Rest, #{is_word => false, children => #{}}),
            maps:put(children, maps:put(Char, NewChildNode, Children), Node)
    end.

find_replacement(Trie, Word) ->
    find_shortest_prefix_optimized(Word, Word, Trie, 0, 0).

find_shortest_prefix_optimized(OriginalWord, WordChars, CurrentNode, CurrentLength, ShortestFoundLength) ->
    case WordChars of
        [] ->
            % Reached the end of the word
            case ShortestFoundLength of
                0 -> OriginalWord; % No root found as prefix
                _ -> lists:sublist(OriginalWord, ShortestFoundLength)
            end;
        [Char|Rest] ->
            Children = maps:get(children, CurrentNode),
            case maps:find(Char, Children) of
                {ok, ChildNode} ->
                    NewCurrentLength = CurrentLength + 1,
                    NewShortestFoundLength =
                        case maps:get(is_word, ChildNode) of
                            true -> NewCurrentLength; % Found a root, this is the shortest one so far
                            false -> ShortestFoundLength
                        end,
                    find_shortest_prefix_optimized(OriginalWord, Rest, ChildNode, NewCurrentLength, NewShortestFoundLength);
                undefined ->
                    % No more prefix match in the Trie
                    case ShortestFoundLength of
                        0 -> OriginalWord; % No root found as prefix
                        _ -> lists:sublist(OriginalWord, ShortestFoundLength)
                    end
            end
    end.