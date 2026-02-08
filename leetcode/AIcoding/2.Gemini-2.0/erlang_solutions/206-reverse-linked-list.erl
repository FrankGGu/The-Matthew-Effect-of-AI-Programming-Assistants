-module(reverse_list).
-export([reverseList/1]).

reverseList(Head) ->
  reverseList(Head, nil).

reverseList(nil, Acc) ->
  Acc;
reverseList(Head, Acc) ->
  Next = Head#link.next,
  Head#link{next = Acc},
  reverseList(Next, Head).