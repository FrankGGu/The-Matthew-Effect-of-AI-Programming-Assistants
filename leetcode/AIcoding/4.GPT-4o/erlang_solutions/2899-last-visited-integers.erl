-module(last_visited_integers).
-export([last_visited/2]).

last_visited(N, L) when is_integer(N), is_list(L) ->
    lists:reverse(lists:take(N, lists:reverse(L))).