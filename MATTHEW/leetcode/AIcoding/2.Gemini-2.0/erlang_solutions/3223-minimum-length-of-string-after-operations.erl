-module(min_length_after_operations).
-export([min_length/1]).

min_length(S) ->
  Len = length(S),
  min_length_helper(S, Len).

min_length_helper(S, Len) ->
  case remove_ab(S) of
    NewS1 ->
      case remove_cd(NewS1) of
        NewS2 ->
          NewLen = length(NewS2),
          if NewLen < Len ->
            min_length_helper(NewS2, NewLen);
          true ->
            Len
          end
      end
  end.

remove_ab(S) ->
  remove_substring(S, "AB").

remove_cd(S) ->
  remove_substring(S, "CD").

remove_substring(S, Substring) ->
  remove_substring_helper(S, Substring, []).

remove_substring_helper([], _, Acc) ->
  lists:reverse(Acc);

remove_substring_helper(S, Substring, Acc) ->
  case string:str(S, Substring) of
    0 ->
      lists:reverse(Acc) ++ S;
    N ->
      Before = lists:sublist(S, N - 1),
      After = lists:nthtail(N + length(Substring) - 1, S),
      remove_substring_helper(After, Substring, lists:reverse(Before) ++ Acc)
  end.