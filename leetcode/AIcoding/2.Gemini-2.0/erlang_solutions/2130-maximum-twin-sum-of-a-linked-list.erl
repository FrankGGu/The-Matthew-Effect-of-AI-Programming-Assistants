-module(solution).
-export([pairSum/1]).

pairSum(Head) ->
  Len = list_length(Head),
  Mid = Len div 2,
  {FirstHalf, SecondHalfReversed} = split_and_reverse(Head, Mid, []),
  max_twin_sum(FirstHalf, SecondHalfReversed).

list_length(List) ->
  list_length(List, 0).

list_length([], Acc) ->
  Acc;
list_length([_|T], Acc) ->
  list_length(T, Acc + 1).

split_and_reverse(List, 0, Acc) ->
  {[], lists:reverse(Acc) ++ List};
split_and_reverse([H|T], N, Acc) ->
  split_and_reverse(T, N - 1, [H | Acc]).

max_twin_sum(List1, List2) ->
  max_twin_sum(List1, List2, 0).

max_twin_sum([], [], Max) ->
  Max;
max_twin_sum([H1|T1], [H2|T2], Max) ->
  Sum = H1 + H2,
  NewMax = max(Max, Sum),
  max_twin_sum(T1, T2, NewMax).

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.