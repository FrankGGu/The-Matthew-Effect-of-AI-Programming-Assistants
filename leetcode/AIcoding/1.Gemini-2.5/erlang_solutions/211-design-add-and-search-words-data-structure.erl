-module(word_dictionary).
-export([new/0, addWord/2, search/2]).

new() ->
    #{is_word_end => false, children => #{}}.

addWord(Trie, Word) ->
    add_word_recursive(Trie, unicode:characters_to_list(Word)).

add_word_recursive(Node, []) ->
    maps:put(is_word_end, true, Node);
add_word_recursive(Node, [Char | RestWord]) ->
    Children = maps:get(children, Node),
    ChildNode = maps:get(Char, Children, new()),
    UpdatedChildNode = add_word_recursive(ChildNode, RestWord),
    UpdatedChildren = maps:put(Char, UpdatedChildNode, Children),
    maps:put(children, UpdatedChildren, Node).

search(Trie, Word) ->
    search_recursive(Trie, unicode:characters_to_list(Word)).

search_recursive(Node, []) ->
    maps:get(is_word_end, Node);
search_recursive(Node, [Char | RestWord]) ->
    Children = maps:get(children, Node),
    case Char of
        $. ->
            lists:any(fun(ChildNode) ->
                          search_recursive(ChildNode, RestWord)
                      end, maps:values(Children));
        _ ->
            case maps:find(Char, Children) of
                {ok, ChildNode} ->
                    search_recursive(ChildNode, RestWord);
                _ ->
                    false
            end
    end.