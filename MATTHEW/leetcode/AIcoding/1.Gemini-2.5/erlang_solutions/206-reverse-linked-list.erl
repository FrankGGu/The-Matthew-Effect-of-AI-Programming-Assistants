-module(solution).
-export([reverseList/1]).

reverseList(Head) ->
    reverseList(Head, nil).

reverseList(nil, Acc) ->
    Acc;
reverseList({Val, Next}, Acc) ->
    reverseList(Next, {Val, Acc}).