-module(trie).
-export([new/0, insert/2, search/2, startsWith/2]).

-record(node, {is_end = false, children = #{}}).

new() ->
    #node{}.

insert(Word, Trie) ->
    insert_helper(Word, Trie).

insert_helper([], Node) ->
    Node#node{is_end = true};
insert_helper([Char | Rest], #node{children = Children} = Node) ->
    Child = maps:get(Char, Children, new()),
    UpdatedChild = insert_helper(Rest, Child),
    Node#node{children = Children#{Char => UpdatedChild}}.

search(Word, Trie) ->
    case search_helper(Word, Trie) of
        {found, Node} -> Node#node.is_end;
        not_found -> false
    end.

startsWith(Prefix, Trie) ->
    case search_helper(Prefix, Trie) of
        {found, _Node} -> true;
        not_found -> false
    end.

search_helper([], Node) ->
    {found, Node};
search_helper([Char | Rest], #node{children = Children}) ->
    case maps:find(Char, Children) of
        {ok, Child} -> search_helper(Rest, Child);
        error -> not_found
    end.