-module(word_dictionary).
-export([new/0, add_word/2, search/2]).

-record(node, {children = dict:new(), is_end = false}).

new() ->
    #node{}.

add_word(Word, Root) ->
    add_word(Word, 1, Root).

add_word([], _, Root) ->
    Root;
add_word([Char | Rest], Index, Root) ->
    Child = case dict:is_key(Char, Root#node.children) of
                true -> dict:fetch(Char, Root#node.children);
                false -> #node{}
            end,
    NewChild = add_word(Rest, Index + 1, Child),
    dict:store(Char, NewChild, Root#node.children).

search(Word, Root) ->
    search(Word, 1, Root).

search([], _, _) ->
    true;
search([Char | Rest], Index, Root) ->
    case Char of
        $. ->
            lists:any(fun({_K, Child}) -> search(Rest, Index + 1, Child) end, dict:to_list(Root#node.children));
        _ ->
            case dict:is_key(Char, Root#node.children) of
                true -> search(Rest, Index + 1, dict:fetch(Char, Root#node.children));
                false -> false
            end
    end.