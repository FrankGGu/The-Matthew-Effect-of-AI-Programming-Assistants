-module(solution).
-export([bonus/3]).

bonus(N, Leadership, Operations) ->
    Tree = build_tree(N, Leadership),
    {Res, _} = lists:foldl(fun(Op, {Acc, Tree0}) ->
        {NewTree, Delta} = execute_op(Op, Tree0),
        {[Delta | Acc], NewTree}
    end, {[], Tree}, Operations),
    lists:reverse(Res).

build_tree(N, Leadership) ->
    Tree = maps:new(),
    lists:foldl(fun([U, V], T) ->
        Children = maps:get(U, T, []),
        maps:put(U, [V | Children], T)
    end, Tree, Leadership).

execute_op(["1", U, X], Tree) ->
    {Tree, update_tree(1, list_to_integer(U), list_to_integer(X), Tree)};
execute_op(["2", U, X], Tree) ->
    {Tree, update_tree(2, list_to_integer(U), list_to_integer(X), Tree)};
execute_op(["3", U], Tree) ->
    Sum = query_tree(list_to_integer(U), Tree),
    {Tree, Sum}.

update_tree(1, U, X, Tree) ->
    X;
update_tree(2, U, X, Tree) ->
    Children = maps:get(U, Tree, []),
    lists:foldl(fun(Child, Sum) ->
        Sum + update_tree(2, Child, X, Tree)
    end, 0, Children) + X.

query_tree(U, Tree) ->
    Children = maps:get(U, Tree, []),
    lists:foldl(fun(Child, Sum) ->
        Sum + query_tree(Child, Tree)
    end, 0, Children) + 0.