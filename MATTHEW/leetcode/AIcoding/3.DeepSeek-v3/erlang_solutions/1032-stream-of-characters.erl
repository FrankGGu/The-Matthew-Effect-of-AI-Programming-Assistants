-module(stream_checker).
-export([init/1, query/2]).

-record(node, {children = #{}, is_end = false}).

init(Words) ->
    Root = build_trie(Words),
    {Root, []}.

query(Letter, {Root, Stream}) ->
    NewStream = [Letter | Stream],
    {check_suffix(Root, NewStream), {Root, NewStream}}.

build_trie(Words) ->
    Root = #node{},
    lists:foldl(fun(Word, Acc) -> insert_word(Acc, Word) end, Root, Words).

insert_word(Root, Word) ->
    lists:foldl(fun(Char, Node) ->
        Children = Node#node.children,
        case maps:get(Char, Children, undefined) of
            undefined ->
                NewChild = #node{},
                Node#node{children = maps:put(Char, NewChild, Children)};
            Child ->
                Node#node{children = maps:put(Char, Child, Children)}
        end
    end, Root, lists:reverse(Word)).

check_suffix(Root, Stream) ->
    check_suffix(Root, Stream, false).

check_suffix(_Node, [], Found) ->
    Found;
check_suffix(Node, [Char | Rest], Found) ->
    case maps:get(Char, Node#node.children, undefined) of
        undefined ->
            Found;
        Child ->
            NewFound = Found orelse Child#node.is_end,
            check_suffix(Child, Rest, NewFound)
    end.