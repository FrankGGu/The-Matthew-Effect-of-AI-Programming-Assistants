-module(stream_checker).
-export([new/1, query/2]).

-define(MAX_WORD_LEN, 10). % Maximum word length according to problem constraints

new(Words) ->
    Trie = build_trie(Words),
    #{trie => Trie, stream => []}.

build_trie(Words) ->
    lists:foldl(fun(Word, AccTrie) ->
                        insert_reversed_word(lists:reverse(Word), AccTrie)
                end, #{}, Words).

insert_reversed_word(ReversedWord, Trie) ->
    insert_reversed_word_recursive(ReversedWord, Trie).

insert_reversed_word_recursive([], CurrentNode) ->
    maps:put(_is_word, true, CurrentNode);
insert_reversed_word_recursive([H|T], CurrentNode) ->
    ChildNode = maps:get(H, CurrentNode, #{}), % Get existing child node or an empty map
    NewChildNode = insert_reversed_word_recursive(T, ChildNode),
    maps:put(H, NewChildNode, CurrentNode).

query(Char, #{trie := Trie, stream := CurrentStream}) ->
    % Add the new character to the front of the stream (maintaining reversed order)
    NewStream = [Char | CurrentStream],

    % Trim the stream to keep only the last MAX_WORD_LEN characters (in reversed order)
    TrimmedStream = if length(NewStream) > ?MAX_WORD_LEN ->
                            lists:sublist(NewStream, 1, ?MAX_WORD_LEN);
                        true ->
                            NewStream
                    end,

    % Check if any prefix of TrimmedStream (which corresponds to a suffix of the actual stream)
    % forms a word in the reversed Trie.
    Found = check_stream_for_word(TrimmedStream, Trie),

    {Found, #{trie => Trie, stream => TrimmedStream}}.

check_stream_for_word(ReversedStreamSuffix, TrieRoot) ->
    check_stream_for_word_recursive(ReversedStreamSuffix, TrieRoot).

check_stream_for_word_recursive([], _CurrentNode) ->
    false; % No more characters to check along this path, and no word found yet
check_stream_for_word_recursive([H|T], CurrentNode) ->
    case maps:find(H, CurrentNode) of
        {ok, NextNode} ->
            % Check if the path leading to NextNode forms a complete word
            IsWord = maps:get(_is_word, NextNode, false),

            % If a word is found, return true immediately (short-circuiting).
            % Otherwise, continue checking deeper into the Trie.
            IsWord orelse check_stream_for_word_recursive(T, NextNode);
        error ->
            false % The current character is not a child of CurrentNode,
                  % so no word can be formed further along this path.
    end.