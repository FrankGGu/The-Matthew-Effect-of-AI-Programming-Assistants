-module(flatten).
-export([flatten/1]).

-spec flatten(list()) -> list().
flatten(List) ->
  flatten_helper(List, []).

flatten_helper([], Acc) ->
  lists:reverse(Acc);
flatten_helper([H|T], Acc) ->
  case H of
    {Val, Next, Prev, Child} ->
      NewAcc = [Val | Acc],
      case Child of
        [] ->
          flatten_helper(Next, NewAcc);
        _ ->
          ChildList = flatten_helper(Child, []),
          flatten_helper(Next, lists:reverse(ChildList) ++ NewAcc)
      end;
    Val ->
      flatten_helper(T, [Val|Acc])
  end.