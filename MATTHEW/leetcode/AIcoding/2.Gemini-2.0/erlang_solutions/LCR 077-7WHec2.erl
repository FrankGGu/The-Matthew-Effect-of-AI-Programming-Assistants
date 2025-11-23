-module(sort_list).
-export([sort_list/1]).

sort_list(Head) ->
  lists:sort(fun(A, B) -> A < B end, to_list(Head)).

to_list(Head) ->
  to_list(Head, []).

to_list(null, Acc) ->
  lists:reverse(Acc);
to_list({Val, Next}, Acc) ->
  to_list(Next, [Val | Acc]).