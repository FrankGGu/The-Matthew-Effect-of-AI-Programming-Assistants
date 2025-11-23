-module(flatten_multilevel_doubly_linked_list).

-export([flatten/1]).

-spec flatten(list()) -> list().
flatten(List) ->
  flatten_helper(List, []).

flatten_helper([], Acc) ->
  lists:reverse(Acc);
flatten_helper([H|T], Acc) ->
  case H of
    {Val, Child, Next, Prev} ->
      NewAcc = [Val|Acc],
      NewAcc2 = flatten_helper(Child, NewAcc),
      flatten_helper(Next, NewAcc2);
    Val ->
      flatten_helper(T, [Val|Acc]);
    null ->
        lists:reverse(Acc);
    _ ->
        flatten_helper(T,Acc)
  end.