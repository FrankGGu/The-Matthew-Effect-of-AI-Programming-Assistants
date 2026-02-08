-module(insertion_sort_list).
-export([insertion_sort_list/1]).

insertion_sort_list(List) ->
  insertion_sort_list_helper(List, []).

insertion_sort_list_helper([], Sorted) ->
  lists:reverse(Sorted);
insertion_sort_list_helper([H|T], Sorted) ->
  insertion_sort(H, Sorted, [] ,insertion_sort_list_helper(T, [])).

insertion_sort(Val, [], Acc, Cont) ->
  Cont;
insertion_sort(Val, [H|T], Acc, Cont) when Val < H ->
  lists:reverse([Val|Acc]) ++ [H|T];
insertion_sort(Val, [H|T], Acc, Cont) ->
  insertion_sort(Val, T, [H|Acc], Cont).