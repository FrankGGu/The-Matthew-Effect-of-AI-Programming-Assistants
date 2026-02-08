-module(solution).
-export([leaf_similar/2]).

leaf_similar(Root1, Root2) ->
    get_leaf_sequence(Root1) == get_leaf_sequence(Root2).

get_leaf_sequence(null) ->
    [];
get_leaf_sequence(#{val := Val, left := null, right := null}) ->
    [Val];
get_leaf_sequence(#{left := Left, right := Right}) ->
    get_leaf_sequence(Left) ++ get_leaf_sequence(Right).