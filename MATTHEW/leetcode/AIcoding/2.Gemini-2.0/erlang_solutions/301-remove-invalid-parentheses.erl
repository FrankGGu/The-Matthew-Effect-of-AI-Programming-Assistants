-module(remove_invalid_parentheses).
-export([remove_invalid_parentheses/1]).

remove_invalid_parentheses(S) ->
  remove_invalid_parentheses(S, lists:seq(1, length(S)), [], []).

remove_invalid_parentheses(S, Indices, Acc, Visited) ->
  case is_valid(S) of
    true ->
      lists:sort(lists:usort(Acc ++ [S]));
    false ->
      case Indices of
        [] ->
          lists:sort(lists:usort(Acc));
        [I | Rest] ->
          Substr = string:substr(S, 1, I - 1) ++ string:substr(S, I + 1, length(S) - I),
          case lists:member(Substr, Visited) of
            true ->
              remove_invalid_parentheses(S, Rest, Acc, Visited);
            false ->
              remove_invalid_parentheses(S, Rest, Acc, [Substr | Visited]) ++
              remove_invalid_parentheses(Substr, lists:seq(1, length(Substr)), Acc, [Substr | Visited])
          end
      end
  end.

is_valid(S) ->
  is_valid(S, 0).

is_valid("", Count) ->
  Count == 0;
is_valid([H | T], Count) ->
  case H of
    $( ->
      is_valid(T, Count + 1);
    $) ->
      case Count > 0 of
        true ->
          is_valid(T, Count - 1);
        false ->
          false
      end;
    _ ->
      is_valid(T, Count)
  end.