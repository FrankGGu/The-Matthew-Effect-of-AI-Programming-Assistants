-module(maximize_greatness).
-export([maximize_greatness/1]).

maximize_greatness(Nums) ->
  SortedNums = lists:sort(Nums),
  maximize_greatness_helper(SortedNums, SortedNums, 0).

maximize_greatness_helper([], _, Count) ->
  Count;
maximize_greatness_helper([H|T], Sorted, Count) ->
  case lists:dropwhile(fun(X) -> X =< H end, Sorted) of
    [] ->
      maximize_greatness_helper(T, Sorted, Count);
    [Greater|Rest] ->
      NewSorted = lists:delete(Greater, Sorted),
      maximize_greatness_helper(T, NewSorted, Count + 1)
  end.