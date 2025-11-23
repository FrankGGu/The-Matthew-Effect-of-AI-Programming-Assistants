-module(stream_of_characters).
-export([insert/2, search/1]).

-record(node, {children = [], is_end = false}).

-type trie() :: #node{}.

-insert([], _Trie) -> ok;
-insert([H|T], Trie) ->
    case lists:keymember(H, 1, Trie#node.children) of
        true ->
            {value, Child} = lists:keyfind(H, 1, Trie#node.children),
            insert(T, Child);
        false ->
            NewChild = #node{},
            NewChildren = lists:keystore(H, 1, Trie#node.children, {H, NewChild}),
            insert(T, NewChild)
    end.

-search([]) -> false;
-search([H|T]) ->
    SearchFun = fun(Node) ->
        case lists:keymember(H, 1, Node#node.children) of
            true ->
                {value, Child} = lists:keyfind(H, 1, Node#node.children),
                case T of
                    [] -> Child#node.is_end;
                    _ -> search(T, Child)
                end;
            false -> false
        end
    end,
    SearchFun(#node{children = []}).

search([], _Trie) -> false;
search([H|T], Trie) ->
    case lists:keymember(H, 1, Trie#node.children) of
        true ->
            {value, Child} = lists:keyfind(H, 1, Trie#node.children),
            case T of
                [] -> Child#node.is_end;
                _ -> search(T, Child)
            end;
        false -> false
    end.