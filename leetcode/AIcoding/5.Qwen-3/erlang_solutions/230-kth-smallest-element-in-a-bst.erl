-module(solution).
-export([kth_smallest/2]).

kth_smallest(Root, K) ->
    inorder(Root, K, []).

inorder(nil, _K, Acc) ->
    lists:nth(K, Acc);
inorder({Val, Left, Right}, K, Acc) ->
    inorder(Left, K, Acc),
    inorder(Right, K, [Val | Acc]).