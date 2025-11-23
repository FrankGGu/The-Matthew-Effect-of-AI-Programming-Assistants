-module(solution).
-export([sum_prefix_scores/1]).

trie_new() ->
    #{children => #{}, count => 0}.

trie_insert(Trie, WordChars) ->
    insert_recursive(Trie, WordChars).

insert_recursive(CurrentNode, []) ->
    CurrentNode.

insert_recursive(CurrentNode, [Char|Rest]) ->
    Children = maps:get(children, CurrentNode),

    case maps:find(Char, Children) of
        {ok, ChildNode} ->
            UpdatedChildNodeCount = maps:get(count, ChildNode) + 1,
            UpdatedChildNodeWithCount = ChildNode#{count := UpdatedChildNodeCount},

            UpdatedChildNode = insert_recursive(UpdatedChildNodeWithCount, Rest),
            UpdatedChildren = maps:put(Char, UpdatedChildNode, Children),
            CurrentNode#{children := UpdatedChildren};
        error ->
            NewChildNode = trie_new()#{count := 1},

            UpdatedChildNode = insert_recursive(NewChildNode, Rest),
            UpdatedChildren = maps:put(Char, UpdatedChildNode, Children),
            CurrentNode#{children := UpdatedChildren}
    end.

get_score(Trie, WordChars) ->
    get_score_recursive(Trie, WordChars, 0).

get_score_recursive(_CurrentNode, [], CurrentScore) ->
    CurrentScore;
get_score_recursive(CurrentNode, [Char|Rest], CurrentScore) ->
    Children = maps:get(children, CurrentNode),
    case maps:find(Char, Children) of
        {ok, ChildNode} ->
            ScoreForPrefix = maps:get(count, ChildNode),
            get_score_recursive(ChildNode, Rest, CurrentScore + ScoreForPrefix);
        error ->
            0
    end.

sum_prefix_scores(Words) ->
    WordCharLists = lists:map(fun(Word) -> unicode:characters_to_list(Word) end, Words),

    InitialTrie = trie_new(),
    BuiltTrie = lists:foldl(fun(WordChars, AccTrie) ->
                                    trie_insert(AccTrie, WordChars)
                            end, InitialTrie, WordCharLists),

    lists:map(fun(WordChars) ->
                      get_score(BuiltTrie, WordChars)
              end, WordCharLists).