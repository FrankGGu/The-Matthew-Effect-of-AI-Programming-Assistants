-module(trie).
-export([new/0, insert/2, search/2, starts_with/2]).

-record(node, {children = dict:new(), is_end = false}).

new() ->
    #node{}.

insert(Trie, Word) ->
    insert_helper(Trie, Word, 1).

insert_helper(Node, Word, Index) ->
    case Index > string:length(Word) of
        true -> 
            Node#node{is_end = true};
        false ->
            Char = string:substr(Word, Index, 1),
            Children = Node#node.children,
            ChildNode = case dict:find(Char, Children) of
                error -> 
                    NewChild = new(),
                    dict:store(Char, NewChild, Children);
                {ok, ChildNode} -> 
                    ChildNode
            end,
            NewNode = insert_helper(ChildNode, Word, Index + 1),
            Node#node{children = dict:store(Char, NewNode, Children)}
    end.

search(Trie, Word) ->
    search_helper(Trie, Word, 1).

search_helper(Node, Word, Index) ->
    case Index > string:length(Word) of
        true -> 
            Node#node.is_end;
        false ->
            Char = string:substr(Word, Index, 1),
            case dict:find(Char, Node#node.children) of
                error -> 
                    false;
                {ok, ChildNode} -> 
                    search_helper(ChildNode, Word, Index + 1)
            end
    end.

starts_with(Trie, Prefix) ->
    starts_with_helper(Trie, Prefix, 1).

starts_with_helper(Node, Prefix, Index) ->
    case Index > string:length(Prefix) of
        true -> 
            true;
        false ->
            Char = string:substr(Prefix, Index, 1),
            case dict:find(Char, Node#node.children) of
                error -> 
                    false;
                {ok, ChildNode} -> 
                    starts_with_helper(ChildNode, Prefix, Index + 1)
            end
    end.