-module(solution).
-export([search_insert/2]).

search_insert(List, Target) ->
    search_insert(List, Target, 0).

search_insert([], Target, Index) ->
    Index;
search_insert([H | T], Target, Index) when H >= Target ->
    Index;
search_insert([_ | T], Target, Index) ->
    search_insert(T, Target, Index + 1).