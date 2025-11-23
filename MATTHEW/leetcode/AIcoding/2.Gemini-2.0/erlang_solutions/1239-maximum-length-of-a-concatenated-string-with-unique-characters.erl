-module(max_length_concatenated_string).
-export([max_length/1]).

max_length(Arr) ->
  max_length_helper(Arr, [], 0).

max_length_helper([], Acc, Max) ->
  max(length(lists:flatten(Acc)), Max);
max_length_helper([H|T], Acc, Max) ->
  case is_unique(H) of
    true ->
      NewAcc = lists:filter(fun(X) -> is_disjoint(X, H) end, Acc),
      NewAcc2 = [H|NewAcc],
      max_length_helper(T, NewAcc2, max(length(lists:flatten(Acc)), Max));
    false ->
      max_length_helper(T, Acc, Max)
  end.

is_unique(Str) ->
  Set = sets:from_list(string:to_list(Str)),
  length(string:to_list(Str)) == sets:size(Set).

is_disjoint(Str1, Str2) ->
  Set1 = sets:from_list(string:to_list(Str1)),
  Set2 = sets:from_list(string:to_list(Str2)),
  sets:is_empty(sets:intersection(Set1, Set2)).