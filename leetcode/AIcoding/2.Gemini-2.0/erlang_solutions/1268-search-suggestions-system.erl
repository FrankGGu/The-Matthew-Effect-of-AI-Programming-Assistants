-module(search_suggestions_system).
-export([suggestedProducts/2]).

suggestedProducts(Repository, SearchWord) ->
  lists:sort(Repository, fun(A, B) -> A < B end),
  suggestedProductsHelper(Repository, SearchWord, []).

suggestedProductsHelper(_Repository, [], Acc) ->
  lists:reverse(Acc);
suggestedProductsHelper(Repository, [H | T], Acc) ->
  Prefix = lists:reverse(Acc) ++ [H],
  Filtered = [S || S <- Repository, string:prefix(S, Prefix)],
  Suggestions = lists:sublist(Filtered, 3),
  suggestedProductsHelper(Repository, T, [Suggestions | Acc]).