-module(remove_outermost_parentheses).
-export([remove_outer_parentheses/1]).

remove_outer_parentheses(S) ->
  remove_outer_parentheses(S, 0, []).

remove_outer_parentheses([], _, Acc) ->
  lists:reverse(Acc);
remove_outer_parentheses([H|T], Balance, Acc) ->
  case H of
    $( ->
      if Balance > 0 ->
        remove_outer_parentheses(T, Balance + 1, [H|Acc])
      else
        remove_outer_parentheses(T, Balance + 1, Acc)
      end;
    $) ->
      if Balance > 1 ->
        remove_outer_parentheses(T, Balance - 1, [H|Acc])
      else
        remove_outer_parentheses(T, Balance - 1, Acc)
      end
  end.