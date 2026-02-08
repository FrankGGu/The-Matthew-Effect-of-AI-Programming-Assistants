-module(remove_duplicates).
-export([remove_duplicates/1]).

remove_duplicates(S) ->
  remove_duplicates_helper(S, []).

remove_duplicates_helper([], Acc) ->
  lists:reverse(Acc);
remove_duplicates_helper([H|T], Acc) ->
  case Acc of
    [H|Rest] ->
      remove_duplicates_helper(T, Rest);
    _ ->
      remove_duplicates_helper(T, [H|Acc])
  end.