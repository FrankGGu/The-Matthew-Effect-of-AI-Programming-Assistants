-module(search_insert).
-export([search_insert/2]).

search_insert(Nums, Target) ->
  search_insert_helper(Nums, Target, 0).

search_insert_helper([], Target, Index) ->
  Index;
search_insert_helper([H|T], Target, Index) ->
  case H of
    Target ->
      Index;
    _ when H < Target ->
      search_insert_helper(T, Target, Index + 1);
    _ ->
      Index
  end.