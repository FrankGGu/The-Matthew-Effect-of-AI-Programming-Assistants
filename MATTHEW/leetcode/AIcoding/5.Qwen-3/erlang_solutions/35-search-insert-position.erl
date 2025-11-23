-module(search_insert_position).
-export([search_insert/2]).

search_insert([], _) -> 0;
search_insert([H | T], N) when H >= N -> 0;
search_insert([H | T], N) -> 1 + search_insert(T, N).