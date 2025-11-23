-module(remove_nth_from_end).
-export([remove_nth_from_end/2]).

-spec remove_nth_from_end(ListNode :: list(), N :: integer()) -> list().
remove_nth_from_end(Head, N) ->
  remove_nth_from_end_helper(Head, N, 0, []).

remove_nth_from_end_helper([], _N, Count, Acc) ->
  {Count, Acc};
remove_nth_from_end_helper([H|T], N, Count, Acc) ->
  {NewCount, NewAcc} = remove_nth_from_end_helper(T, N, Count + 1, [H|Acc]),
  if NewCount > N then
    {NewCount, lists:reverse(NewAcc)}
  else
    {NewCount, lists:reverse(T)}
  end.