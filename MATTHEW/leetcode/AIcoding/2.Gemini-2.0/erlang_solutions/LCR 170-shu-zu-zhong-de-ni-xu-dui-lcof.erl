-module(transaction_inversions).
-export([solve/1]).

solve(Transactions) ->
  solve(Transactions, 0).

solve([], Acc) ->
  Acc;
solve([H|T], Acc) ->
  Inversions = count_inversions(H),
  solve(T, Acc + Inversions).

count_inversions(Transaction) ->
  count_inversions(Transaction, 0).

count_inversions([], Acc) ->
  Acc;
count_inversions([H|T], Acc) ->
  Acc1 = Acc + count_smaller(H, T),
  count_inversions(T, Acc1).

count_smaller(_, []) ->
  0;
count_smaller(Value, [H|T]) ->
  case H < Value of
    true ->
      1 + count_smaller(Value, T);
    false ->
      count_smaller(Value, T)
  end.