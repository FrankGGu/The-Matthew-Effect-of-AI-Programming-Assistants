-module(remove_trailing_zeros).
-export([remove_trailing_zeros/1]).

remove_trailing_zeros(S) ->
    lists:reverse(remove_trailing_zeros_rev(lists:reverse(S))).

remove_trailing_zeros_rev([]) ->
    [];
remove_trailing_zeros_rev([$0|T]) ->
    remove_trailing_zeros_rev(T);
remove_trailing_zeros_rev(L) ->
    L.