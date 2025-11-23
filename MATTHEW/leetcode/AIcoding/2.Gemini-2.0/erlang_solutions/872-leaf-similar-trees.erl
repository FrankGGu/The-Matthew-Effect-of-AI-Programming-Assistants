-module(leaf_similar).
-export([leaf_similar/2]).

leaf_similar(Root1, Root2) ->
    leaves(Root1) == leaves(Root2).

leaves(null) ->
    [].
leaves({null, Val, null}) ->
    [Val];
leaves({Left, Val, Right}) ->
    leaves(Left) ++ leaves({null,Val,null}) ++ leaves(Right) ;
leaves({Left, null, Right}) ->
    leaves(Left) ++ leaves(Right) ;
leaves({Left, Val, null}) ->
    leaves(Left) ++ leaves({null,Val,null});
leaves({null, Val, Right}) ->
    leaves({null,Val,null}) ++ leaves(Right) ;
leaves(Node) ->
    lists:flatten([leaves(element(1, Node)), leaves(element(2, Node)), leaves(element(3, Node))]).