-module(solution).
-export([suggested_products/2]).

suggested_products(ProductList, SearchWord) ->
    Trie = build_trie(ProductList),
    search_suggestions(Trie, SearchWord, []).

build_trie(ProductList) ->
    Trie = maps:from_list([{<<0>> , []}]),
    lists:foldl(fun(Product, Acc) -> insert(Acc, Product) end, Trie, ProductList).

insert(Trie, Product) ->
    lists:foldl(fun(Char, {Next, Suggestions}) ->
        NewNode = maps:get(Char, Next, {maps:make(), []}),
        NewSuggestions = [Product | maps:get(<<0>>, NewNode)],
        NewNext = maps:put(Char, {maps:put(<<0>>, NewSuggestions, NewNode)}, Next),
        {NewNext, NewSuggestions}
    end, {Trie, []}, string:to_list(Product).

search_suggestions(Trie, SearchWord, Acc) ->
    lists:foldl(fun(Char, {Node, Suggestions}) ->
        case maps:get(Char, Node, {maps:make(), []}) of
            {NextNode, SuggestionsList} ->
                {NextNode, SuggestionsList ++ Suggestions};
            _ ->
                {maps:make(), []}
        end
    end, {Trie, []}, string:to_list(SearchWord).