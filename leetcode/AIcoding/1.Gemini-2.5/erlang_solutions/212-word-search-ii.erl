-module(solution).
-export([findWords/2]).

new_trie_node() ->
    {trie_node, #{}, undefined}.

add_word_to_trie(Word, Trie) ->
    add_word_to_trie(Word, 0, Trie).

add_word_to_trie(Word, Idx, {trie_node, Children, WordCompleted}) when Idx < length(Word) ->
    Char = string:at(Word, Idx),
    ChildNode = maps:get(Char, Children, new_trie_node()),
    NewChildNode = add_word_to_trie(Word, Idx + 1, ChildNode),
    {trie_node, maps:put(Char, NewChildNode, Children), WordCompleted};
add_word_to_trie(Word, Idx, {trie_node, Children, _WordCompleted}) when Idx == length(Word) ->
    %% This node completes the word. Set its WordCompleted field.
    {trie_node, Children, Word}.

build_trie(Words) ->
    lists:foldl(fun(Word, Trie) -> add_word_to_trie(Word, Trie) end, new_trie_node(), Words).

findWords(Board, Words) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    Trie = build_trie(Words),

    FoundWordsSet = gb_sets:new(),

    FinalFoundWordsSet = lists:foldl(
        fun(R, AccFoundWords) ->
            lists:foldl(
                fun(C, AccInnerFoundWords) ->
                    dfs(R, C, Trie, Board, Rows, Cols, gb_sets:new(), AccInnerFoundWords)
                end,
                AccFoundWords,
                lists:seq(0, Cols - 1)
            )
        end,
        FoundWordsSet,
        lists:seq(0, Rows - 1)
    ),
    gb_sets:to_list(FinalFoundWordsSet).

dfs(R, C, CurrentTrieNode, Board, Rows, Cols, Visited, FoundWords) ->
    %% Check boundaries
    if
        R < 0; R >= Rows; C < 0; C >= Cols -> FoundWords;
        true ->
            %% Check if cell already visited in current path
            if
                gb_sets:is_member({R, C}, Visited) -> FoundWords;
                true ->
                    CharList = lists:nth(R + 1, Board),
                    Char = lists:nth(C + 1, CharList),

                    {trie_node, Children, _} = CurrentTrieNode, %% Destructure CurrentTrieNode to get children

                    case maps:find(Char, Children) of
                        {ok, NextTrieNode} ->
                            {trie_node, _, WordCompleted} = NextTrieNode, %% Destructure NextTrieNode to check for completed word

                            NewFoundWords = 
                                if
                                    WordCompleted =/= undefined -> gb_sets:add(WordCompleted, FoundWords);
                                    true -> FoundWords
                                end,

                            NewVisited = gb_sets:add({R, C}, Visited),

                            %% Explore neighbors
                            FoundWords1 = dfs(R + 1, C, NextTrieNode, Board, Rows, Cols, NewVisited, NewFoundWords),
                            FoundWords2 = dfs(R - 1, C, NextTrieNode, Board, Rows, Cols, NewVisited, FoundWords1),
                            FoundWords3 = dfs(R, C + 1, NextTrieNode, Board, Rows, Cols, NewVisited, FoundWords2),
                            FoundWords4 = dfs(R, C - 1, NextTrieNode, Board, Rows, Cols, NewVisited, FoundWords3),
                            FoundWords4;
                        error ->
                            %% Character not found in Trie, prune path
                            FoundWords
                    end
            end
    end.