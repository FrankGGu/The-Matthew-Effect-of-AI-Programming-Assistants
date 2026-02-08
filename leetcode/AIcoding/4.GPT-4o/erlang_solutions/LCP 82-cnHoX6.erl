-module(solution).
-export([max_sum/1]).

max_sum(Tree) ->
    max_sum(Tree, 0).

max_sum([], Acc) ->
    Acc;
max_sum([{Node, Left, Right} | Tail], Acc) ->
    NewAcc = Acc + Node,
    max(max_sum(Left, NewAcc), max_sum(Right, NewAcc));
max_sum([Node | Tail], Acc) ->
    max_sum(Tail, Acc).